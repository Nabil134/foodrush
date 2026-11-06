import 'package:flutter/material.dart';
import 'package:food_rush/core/constant/app_colors.dart';
import 'package:food_rush/features/cart/providers/cart_provider.dart';
import 'package:food_rush/features/payment/providers/payment_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/snackbar_utils.dart';
class Payment extends StatelessWidget {
  const Payment({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) =>
        PaymentProvider(
          cartProvider: context.read<CartProvider>(),
        ),
      child: CheckOutView(),
    );
  }
}
class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final List<String> steps = const ['Shipping', 'Payment', 'Review'];
  @override
  Widget build(BuildContext context) {
    return Consumer2<PaymentProvider,CartProvider>(builder: (context,checkout, cart, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Checkout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(children: [
          /* first portion */
          _buildHorizontalStepper(steps,checkout.currentStep),
          /* first portion */
          /*second portion*/
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  key: ValueKey(checkout.currentStep),
                  duration: const Duration( milliseconds: 300),
                    child: _buildStepContent(checkout,cart),),
              ),
            ),
          ),
          /*second portion*/
          /*last portion*/
          _buildBottomButton(checkout,cart),
          /*last portion*/

        ],),
      );
    },);
  }
/* _buildHorizontalStepper*/
  Widget _buildHorizontalStepper(List<String> steps, int currentStep) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length*2-1, (index){
          if(index%2==0){
            final stepIndex=index~/2;
            final isActive= stepIndex<=currentStep;
            final isCurrentStep=stepIndex==currentStep;
            return Expanded(child: Column(children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive?AppColors.primary:Colors.grey.shade100,
                  border: Border.all(
                    color: isCurrentStep?AppColors.primary:Colors.grey.shade100,
                    width: isCurrentStep?2:1,
                  ),
                  boxShadow: isCurrentStep?[
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ]:null,
                ),
                child: Center(child: isActive?Icon(stepIndex<currentStep?Icons.check:Icons.circle,color: Colors.white,
                  size: stepIndex<currentStep?18:12,):Text("${stepIndex+1}",style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),),),
              ),
              const SizedBox(height: 8,),
              Text(steps[stepIndex],style: TextStyle(
                fontSize: 13,
                color: isActive?AppColors.primary:Colors.grey.shade600,
                fontWeight: isCurrentStep?FontWeight.bold:FontWeight.normal,
              ),),
            ],),);
          }
          else{
            final isActive= index~/2<=currentStep-1;
            return Expanded(
              child:   Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Container(
                  height: 2,
                  color: isActive?AppColors.primary:Colors.grey.shade100,
                ),
              ),
            );
          }
        }),),
    );
  }

/* _buildHorizontalStepper*/
   Widget _buildStepContent(PaymentProvider checkout, CartProvider cart) {
     switch(checkout.currentStep){
       case PaymentProvider.shippingStep:
         return _buildShippingInfoContent(checkout);
       case PaymentProvider.paymentStep:
         return _buildPaymentMethodContent(checkout);
       case PaymentProvider.reviewStep:
         return _buildOrderSummaryContent(checkout,cart);
       default:
         return const SizedBox();
     }
   }
/* _buildHorizontalStepper*/
  /*_buildShippingInfoContent*/
  Widget _buildShippingInfoContent(PaymentProvider checkout) {
    return Container(
      width: double.infinity,
      padding:const  EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          'Shipping Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
          const SizedBox(height: 20,),
          _buildFormField(labelText: "Full Name", onChanged: checkout.updateName, value: checkout.name,icon: Icons.person),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "Email", onChanged: checkout.updateEmail,
              value: checkout.email,icon: Icons.email,keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "Phone Number", onChanged: checkout.updatePhone,
              value: checkout.phone,icon: Icons.phone,keyboardType: TextInputType.phone),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "Address", onChanged: checkout.updateAddress,
              value: checkout.address,icon: Icons.home),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "State", onChanged: checkout.updateState,
              value: checkout.state,icon: Icons.location_on),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "City", onChanged: checkout.updateCity,
              value: checkout.city,icon: Icons.location_city),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "Postal Code", onChanged: checkout.updatePostalCode,
              value: checkout.postalCode,icon: Icons.code),
          const SizedBox(height: 16,),
          _buildFormField(labelText: "Country (2-letter code, e.g. PK)", onChanged: checkout.updateCountry,
              value: checkout.country,icon: Icons.flag),
      ],),
    );
  }

/*_buildShippingInfoContent*/
  /*_cardDecoration*/
 BoxDecoration _cardDecoration() {
   return BoxDecoration(
     color: Colors.white,
     borderRadius: BorderRadius.circular(15),
     boxShadow: [
       BoxShadow(
         color: Colors.grey.shade200,
         blurRadius: 10,
         offset: const Offset(0, 2),
       ),
     ],
   );
 }
/*_cardDecoration*/
/*_buildFormField*/
Widget _buildFormField({required String  labelText,TextInputType? keyboardType,  required ValueChanged<String> onChanged,
  required String value,
  required IconData icon,
}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
      labelText,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),
    ),
      const SizedBox(height: 8,),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200, width: 1,
          ),
        ),
        child: TextFormField(
          key: ValueKey(labelText),
          initialValue: value,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontSize: 14, color: Colors.grey.shade400
            ),
            border: InputBorder.none,
            hintText: "Enter $labelText",
            prefixIcon: Icon(icon,color: AppColors.primary,size: 22,),
          ),
        ),
      ),
  ],);
}
/*_buildFormField*/
/*_buildPaymentMethodContent*/
  Widget _buildPaymentMethodContent(PaymentProvider checkout) {
    return Container(
      width: double.infinity,
      decoration: _cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Select Payment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
            const SizedBox(height: 20,),
            _buildPaymentMethodCard(checkout: checkout, id: PaymentProvider.credit, name: "Credit Card",
                description: "Pay securely with Stripe", icon: Icons.credit_card),
            const SizedBox(height: 20,),
            _buildPaymentMethodCard(checkout: checkout, id: PaymentProvider.debit, name: "Debit Card",
                description: "Pay securely with Stripe", icon: Icons.payment),
            const SizedBox(height: 20,),
            _buildPaymentMethodCard(checkout: checkout, id: PaymentProvider.cod, name: "Cash on Delivery",
                description: "Pay With Cash Upon delivery", icon: Icons.money),
            if(checkout.isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary ,
                  ),
                ),
              ),
        ],),
      ),

    );
  }
/*_buildPaymentMethodContent*/
/*_buildPaymentMethodCard*/
Widget _buildPaymentMethodCard({required PaymentProvider checkout,required String id,required String name,required String description,
  required IconData icon}
    ){
  final isSelected=checkout.isSelected(id);
  return  GestureDetector(
    onTap: (){
      checkout.selectPaymentMethod(id);
    },
    child: AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 18),
      duration:const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isSelected?AppColors.primary:AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected?AppColors.primary:Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: isSelected?[
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ]:null,
      ),
      child: Row(children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: isSelected?Colors.white:AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
            color: isSelected?AppColors.primary:Colors.white,size: 28,),
        ),
        const SizedBox(width: 15,),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(name,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected?Colors.white:Colors.grey.shade800,
            ),),
            Text(description,style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected?Colors.white.withOpacity(0.8):Colors.grey.shade600,
            ),),
          ],),
        ),
        if(isSelected)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child:const Icon(Icons.check,color: Colors.white,size: 16,),
          ),
      ],),
    ),
  );
}
/*_buildPaymentMethodCard*/
  /*_buildOrderSummaryContent*/
  Widget _buildOrderSummaryContent(PaymentProvider checkout, CartProvider cart) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            "Order Item:${cart.items.length}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800
            ),
          ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(children: [
_buildSummaryRow(label: "SubTotal", value: "\$${cart.subTotal.toStringAsFixed(2)}"),
  const SizedBox(height: 12,),
                _buildSummaryRow(label: "Taxes", value: "\$${cart.taxes.toStringAsFixed(2)}"),
                const SizedBox(height: 12,),
                _buildSummaryRow(label: "Delivery fee", value:cart.deliverFee==0?"FREE": "\$${cart.deliverFee.toStringAsFixed(2)}",
                  valueColor: cart.deliverFee==0?Colors.green:null,),
                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade200,),
                const SizedBox(height: 12),
                _buildSummaryRow(label: "Total", value: "\$${cart.totalPrice.toStringAsFixed(2)}",isTotal: true),
                const SizedBox(height: 20),
                Container(
                  padding:const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(children: [
                    Container(height: 40,
                    width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green.shade300,
                          width: 1,
                        ),
                      ),
                      child: Icon(Icons.check,color: Colors.green.shade600,size: 24,),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          'Confirm Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your order will be processed immediately after confirmation',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ],),
                    ),
                  ],),
                ),
              ],),
            ),
        ],),
      ),
    );
  }
/*_buildOrderSummaryContent*/
/*_buildSummaryRow*/
Widget _buildSummaryRow({
    required String label,
  required String value,
  Color? valueColor,
  bool isTotal=false
}){
return Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Text(label,style: TextStyle(
    fontSize: isTotal?18:16,
    color: Colors.grey.shade700,
    fontWeight: isTotal?FontWeight.bold:FontWeight.w500,
  ),),
  Text(value,style: TextStyle(
    fontSize: isTotal?20:16,
    color: valueColor??(isTotal?AppColors.primary:Colors.grey.shade800),
    fontWeight: isTotal?FontWeight.w500:FontWeight.normal,
  ),),
],);
}
/*_buildSummaryRow*/
/*_buildBottomButton*/
 Widget _buildBottomButton(PaymentProvider checkout, CartProvider cart) {
   final currentStep=checkout.currentStep;
   return Container(
     padding: EdgeInsets.fromLTRB(
       16,
       16,
       16,
       MediaQuery.of(context).padding.bottom + 16,
     ),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(15),
       boxShadow: [
         BoxShadow(
           color: Colors.grey.shade200,
           blurRadius: 5,
           offset: const Offset(0, -3),
         ),
       ],
     ),
     child: Row(children: [
       if(currentStep>0&&currentStep<2)
       Container(
         height: 55,
         width: 55,
         margin: const EdgeInsets.only(right: 15),
         child: OutlinedButton(
           style: OutlinedButton.styleFrom(
             padding: EdgeInsets.zero,
             side: BorderSide(
               color:  AppColors.primary,
             ),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15),
             ),
           ),
           onPressed: checkout.isLoading?null:checkout.previousStep, child:  Icon(Icons.arrow_back,color: AppColors.primary,),),
       ),
       Expanded(
         child: SizedBox(
           height: 55,
           child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               elevation: 0,
               disabledBackgroundColor: Colors.grey.shade300,
               foregroundColor: Colors.white,
               backgroundColor:currentStep==2?Colors.green: AppColors.primary,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(15),
               ),
             ),
             onPressed:checkout.isLoading || cart.isEmpty?null: (){
               _onMainButtonPressed(checkout,cart);
             }, child:checkout.isLoading? const SizedBox(
             height: 21,
             width: 21,
             child: CircularProgressIndicator(
               color: Colors.white,
               strokeWidth: 2,
             ),
           ): Text(currentStep==0?"Continue To Payment":currentStep==1?"Confirm To Review":"Place Order",style:
           TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
           ),),),
         ),
       ),
     ],),
   );
 }
/*_buildBottomButton*/
  /*_onMainButtonPressed*/
  Future<void> _onMainButtonPressed(PaymentProvider checkout, CartProvider cart) async {
final step = checkout.currentStep;
if(step==PaymentProvider.shippingStep){
  if(checkout.validateCustomerDetails()){
    checkout.nextStep();
  }
  else{
SnackBarUtils.showMessage(context,checkout.errorMessage.isNotEmpty?checkout.errorMessage:"Please fill in all required fields",isError: true);
  }
  return;
}
if(step==PaymentProvider.paymentStep){
  final success= await checkout.processPayment(amount: cart.totalPrice);
  if(!mounted) return;
  if(success){
checkout.nextStep();
  }
  else{
SnackBarUtils.showMessage(context,checkout.errorMessage.isNotEmpty?checkout.errorMessage:"Payment failed. Please try again.",isError: true);
  }
  return;
}
final order= await checkout.completedOrder(cartProvider: cart);
if(!mounted) return;
if(order==null){
  SnackBarUtils.showMessage(context,checkout.errorMessage.isNotEmpty?checkout.errorMessage:"Failed To Order Complete",isError: true);

  return;
}
else{
  _showOrderProcessingDialog();
}
  }
/*_onMainButtonPressed*/
  /*_showOrderProcessingDialog*/
  Future <void>  _showOrderProcessingDialog()  {
    return showDialog(context: context, builder: (context) =>AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(0.1),
          ),
          child:const Icon(Icons.check_circle_rounded,color: Colors.green,size: 60,),
        ),
          const SizedBox(height: 16),
          const Text(
            'Order placed!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thank you for ordering with FoodRush.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, child: const Text("Continue Shopping"),),),
      ],),
    ),);
  }
/*_showOrderProcessingDialog*/
}