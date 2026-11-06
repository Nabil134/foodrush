import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_rush/core/constant/stripe_appearce.dart';
import 'package:http/http.dart' as http;
import '../../../core/network/api_endponts.dart';
import '../../cart/providers/cart_provider.dart';
import '../../category/models/category_model.dart';
class PaymentProvider extends ChangeNotifier {
  PaymentProvider({CartProvider? cartProvider}) : _cartProvider = cartProvider;

  final CartProvider? _cartProvider;

  // ---------------------------------------------------------------------------
  // Payment methods
  // ---------------------------------------------------------------------------
  static const String cod = 'cod';
  static const String credit = 'credit';
  static const String debit = 'debit';

  String? _selectedPaymentMethod = credit;
  String? get selectedPaymentMethod => _selectedPaymentMethod;

  bool _saveCard = false;
  bool get saveCard => _saveCard;

  void toggleSaveCard() {
    _saveCard = !_saveCard;
    notifyListeners();
  }

  final List<Map<String, String>> _paymentMethods = [
    {'id': credit, 'name': 'Credit card'},
    {'id': debit, 'name': 'Debit card'},
    {'id': cod, 'name': 'Cash on Delivery'},
  ];

  List<Map<String, String>> get paymentMethods =>
      List.unmodifiable(_paymentMethods);

  bool isSelected(String method) => _selectedPaymentMethod == method;

  void selectPaymentMethod(String method) {
    if (!_paymentMethods.any((item) => item['id'] == method)) return;
    _selectedPaymentMethod = method;
    _errorMessage = '';
    notifyListeners();
  }

  // Compatibility with the existing CheckoutScreen.
  void selectMethod(String method) => selectPaymentMethod(method);

  // ---------------------------------------------------------------------------
  // Shipping details
  // ---------------------------------------------------------------------------
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _city = '';
  String _state = '';
  String _postalCode = '';
  String _country = '';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get postalCode => _postalCode;
  String get country => _country;

  void updateName(String v) { _name = v; notifyListeners(); }
  void updateEmail(String v) { _email = v; notifyListeners(); }
  void updatePhone(String v) { _phone = v; notifyListeners(); }
  void updateAddress(String v) { _address = v; notifyListeners(); }
  void updateCity(String v) { _city = v; notifyListeners(); }
  void updateState(String v) { _state = v; notifyListeners(); }
  void updatePostalCode(String v) { _postalCode = v; notifyListeners(); }
  void updateCountry(String v) { _country = v; notifyListeners(); }

  // ---------------------------------------------------------------------------
  // Validation
  // ---------------------------------------------------------------------------
  bool validateCustomerDetails() {
    if (_name.trim().isEmpty ||
        _email.trim().isEmpty ||
        _phone.trim().isEmpty ||
        _address.trim().isEmpty ||
        _city.trim().isEmpty ||
        _state.trim().isEmpty ||
        _postalCode.trim().isEmpty ||
        _country.trim().isEmpty) {
      _errorMessage = 'Please fill in all required fields.';
      notifyListeners();
      return false;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(_email.trim())) {
      _errorMessage = 'Please enter a valid email address.';
      notifyListeners();
      return false;
    }

    if (_phone.trim().length < 7) {
      _errorMessage = 'Please enter a valid phone number.';
      notifyListeners();
      return false;
    }

    // Stripe billing address expects a two-letter country code (PK, US ...).
    if (!RegExp(r'^[A-Za-z]{2}$').hasMatch(_country.trim())) {
      _errorMessage = 'Enter a two-letter country code, such as PK.';
      notifyListeners();
      return false;
    }

    _errorMessage = '';
    notifyListeners();
    return true;
  }

  // ---------------------------------------------------------------------------
  // Checkout steps
  // ---------------------------------------------------------------------------
  static const int shippingStep = 0;
  static const int paymentStep = 1;
  static const int reviewStep = 2;
  static const int totalSteps = 3;
  int _currentStep = shippingStep;
  int get currentStep => _currentStep;

  bool get isFirstStep => _currentStep == shippingStep;
  bool get isLastStep => _currentStep == reviewStep;

  void nextStep() {
    if (_currentStep < reviewStep) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > shippingStep) {
      _currentStep--;
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= shippingStep && step <= reviewStep) {
      _currentStep = step;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // Loading, messages and order state
  // ---------------------------------------------------------------------------
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _successMessage = '';
  String get successMessage => _successMessage;

  String _orderId = '';
  String get orderId => _orderId;

  bool _paymentReadyForCompletion = false;


  // static const String paymentApiUrl =
  //     'https://api.stripe.com/v1/payment_intents';

  static String get _secretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';

  static Map<String, String> get _headers => {
    'Authorization': 'Bearer $_secretKey',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  static Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
    int adminFee = 0,
  }) async {
    if (_secretKey.isEmpty) {
      throw Exception('STRIPE_SECRET_KEY is missing in your .env file.');
    }

    try {
      final int amountInCent = (amount * 100).round();
      final int adminFeeInCent = adminFee * 100;
      final int totalAmountInCent = amountInCent + adminFeeInCent;

      // Stripe expects form-encoded data (a Map), NOT jsonEncode.
      final Map<String, String> body = {
        'amount': totalAmountInCent.toString(),
        'currency': currency.toLowerCase(),
        'payment_method_types[]': 'card',
      };

      final response = await http
          .post(Uri.parse(ApiEndPoints.paymentApiUrl), headers: _headers, body: body)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw Exception('Stripe Error: ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw Exception('Invalid response from Stripe.');
      }
      return decoded;
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Process checkout
  // ---------------------------------------------------------------------------
  Future<bool> processPayment({required double amount}) async {
    if (_isLoading) return false;

    if (!validateCustomerDetails()) return false;

    if (_selectedPaymentMethod == null) {
      _errorMessage = 'Please select a payment method.';
      notifyListeners();
      return false;
    }

    if (amount <= 0 || !amount.isFinite) {
      _errorMessage = 'Your order total must be greater than zero.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = '';
    _successMessage = '';
    _paymentReadyForCompletion = false;
    _orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    notifyListeners();

    try {
      if (_selectedPaymentMethod == cod) {
        await Future.delayed(const Duration(seconds: 1));
        _paymentReadyForCompletion = true;
        _successMessage = 'Order placed. Payment is due on delivery.';
        return true;
      }

      if (_selectedPaymentMethod == credit ||
          _selectedPaymentMethod == debit) {
        final success = await _processStripePaymentSheet(amount: amount);
        if (success) {
          _paymentReadyForCompletion = true;
          _successMessage = 'Payment successful.';
        } else {
          _orderId = '';
        }
        return success;
      }

      _orderId = '';
      _errorMessage = 'Please select a valid payment method.';
      return false;
    } catch (e, stackTrace) {
      debugPrint('Payment error: $e');
      debugPrintStack(stackTrace: stackTrace);
      _orderId = '';
      _errorMessage = 'Payment failed. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // Stripe Payment Sheet
  // ---------------------------------------------------------------------------
  Future<bool> _processStripePaymentSheet({required double amount}) async {
    try {
      if (Stripe.publishableKey.isEmpty) {
        throw Exception('Stripe publishable key is not configured.');
      }

      final paymentIntentData = await createPaymentIntent(
        amount: amount,
        currency: 'usd',
        adminFee: 0,
      );

      if (!paymentIntentData.containsKey('client_secret') ||
          paymentIntentData['client_secret'] == null) {
        throw Exception('Error creating payment intent');
      }

      await Stripe.instance.initPaymentSheet(

        paymentSheetParameters: SetupPaymentSheetParameters(
          appearance:StripeAppearance.foodRush,
          primaryButtonLabel: "Pay \$${amount.toStringAsFixed(2)}",
          paymentIntentClientSecret:
          paymentIntentData['client_secret'] as String,
          style: ThemeMode.light,
          merchantDisplayName: 'FoodRush',
          billingDetails: BillingDetails(
            name: _name.trim(),
            email: _email.trim(),
            phone: _phone.trim(),
            address: Address(
              line1: _address.trim(),
              line2: '',
              city: _city.trim(),
              state: _state.trim(),
              postalCode: _postalCode.trim(),
              country: _country.trim().toUpperCase(),
            ),
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        _errorMessage = 'Payment cancelled.';
      } else {
        _errorMessage =
        'Payment failed: ${e.error.localizedMessage ?? 'Unknown error'}';
      }
      return false;
    } catch (e, stackTrace) {
      debugPrint('Stripe payment error: $e');
      debugPrintStack(stackTrace: stackTrace);
      _errorMessage = 'An error occurred: $e';
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Complete order
  // ---------------------------------------------------------------------------
  Future<Map<String, dynamic>?> completedOrder({
    CartProvider? cartProvider,
  }) async {
    final cart = cartProvider ?? _cartProvider;

    if (cart == null) {
      _errorMessage = 'CartProvider was not provided.';//if cart is null it assign CartProvider was not provided. to  _errorMessage
      notifyListeners();//it update UI
      return null;//it break if block
    }

    if (!_paymentReadyForCompletion || _orderId.isEmpty) {
      _errorMessage = 'Please complete checkout before placing the order.';
      notifyListeners();
      return null;
    }

    try {
      final orderData = <String, dynamic>{
        'order_id': _orderId,
        'customer': {
          'name': _name,
          'email': _email,
          'phone': _phone,
        },
        'shipping': {
          'address': _address,
          'city': _city,
          'state': _state,
          'postalCode': _postalCode,
          'country': _country.toUpperCase(),
        },
        'payment': {
          'method': _selectedPaymentMethod,
          'amount': cart.totalPrice,
          'currency': 'usd',
          'saveCardPreference': _saveCard,
        },
        'items': cart.items.map((Items item) {
          final price = item.price ?? 0.0;
          return <String, dynamic>{
            'product_name': item.name,
            'quantity': item.qty,
            'price': price,
            'total': price * item.qty,
          };
        }).toList(),
        'subtotal': cart.subTotal,
        'taxes': cart.taxes,
        'delivery_fee': cart.deliverFee,
        'total': cart.totalPrice,
        'orderDate': DateTime.now().toIso8601String(),
      };

      await Future.delayed(const Duration(seconds: 2));
      debugPrint('Order Completed: $orderData');

      cart.clearCart();

      _successMessage = 'Order completed successfully.';
      _paymentReadyForCompletion = false;
      _resetForm(notify: false);

      notifyListeners();
      return orderData;
    } catch (e, stackTrace) {
      debugPrint('Order completion error: $e');
      debugPrintStack(stackTrace: stackTrace);
      _errorMessage = 'Failed to complete the order.';//it store Failed to complete the order. to _errorMessage
      notifyListeners();
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Reset / messages
  // ---------------------------------------------------------------------------
  void _resetForm({bool notify = true}) {
    _name = '';
    _email = '';
    _phone = '';
    _address = '';
    _city = '';
    _state = '';
    _postalCode = '';
    _country = '';

    _currentStep = shippingStep;
    _selectedPaymentMethod = credit;
    _saveCard = false;
    _orderId = '';
    _errorMessage = '';
    _paymentReadyForCompletion = false;

    if (notify) notifyListeners();
  }

  void resetCheckout() {
    _successMessage = '';
    _resetForm(notify: false);
    notifyListeners();
  }
  void clearMessages() {
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();
  }
}
