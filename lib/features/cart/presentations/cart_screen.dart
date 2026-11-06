import 'package:flutter/material.dart';
import 'package:food_rush/features/cart/providers/cart_provider.dart';
import 'package:food_rush/features/payment/presentations/payment_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../../category/models/category_model.dart';
import '../../detail/presentations/widgets/circle_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider= context.watch<CartProvider>();
    return Scaffold(
      /* bottomNavigationBar start here*/
      bottomNavigationBar:  cartProvider.items.isNotEmpty? Container(
        padding: EdgeInsets.fromLTRB(
          20, 16, 20,
          MediaQuery.of(context).padding.bottom + 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
           Text(
             'Total',
             style: const TextStyle(
               color: AppColors.black,
               fontSize: 18,
               fontWeight: FontWeight.w600,
             ),
           ),
           Text(
             '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
             style: const TextStyle(
               color: AppColors.black,
               fontSize: 24,
               fontWeight: FontWeight.w600,
             ),
           ),
         ],),
          const SizedBox(width: 15,),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(),),);
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 18),
                    SizedBox(width: 8),
                    const Text(
                      'ORDER NOW',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),),
            ),
          ),
        ],),
      ):null,
      /* bottomNavigationBar end here*/
      body: SafeArea(
        child: Column(children: [
          /*first portion start here*/
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButton(
                  icon: Icons.arrow_back,
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                CircleButton(
                  icon: Icons.search,
                ),
              ],),
          ),
          /*first portion end here*/
/*second portion start here*/
        cartProvider.isEmpty? Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text('Your cart is empty',style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.black,
              ),),
            ],
          ),
        ):ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          shrinkWrap: true,
          itemCount: cartProvider.items.length,
          itemBuilder: (context, index) {
            final item = cartProvider.items[index];
            return  CartItemCard(
            item: item,
              cartProvider: cartProvider,
          );
          },),
          /*second portion end here*/
          /*third portion start here*/
          cartProvider.items.isNotEmpty?
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Toppings',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.black,
                ),),
                const SizedBox(height: 5,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(children: cartProvider.toppings.map((topping) => ToppingCard(
                      image: topping["image"]!,
                    name: topping["name"]!,
                  )).toList()),),
              ],
            ),
          ):const SizedBox.shrink(),
          /*third portion end here*/
          /*last portion start here*/
          cartProvider.items.isNotEmpty?
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Side options',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.black,
                ),),
                const SizedBox(height: 5,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(children: cartProvider.sideOptions.map((sideOptions) => ToppingCard(
                    image: sideOptions["image"]!,
                    name: sideOptions["name"]!,
                  )).toList()),),
              ],
            ),
          ):const SizedBox.shrink(),
          /*last portion end here*/
        ],),
      ),
    );
  }
}
/*ToppingCard start here*/
class ToppingCard extends StatelessWidget {
  const ToppingCard({super.key,required this.image,required this.name});
  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Container(
            height: 58,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.fastfood_rounded,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ),
          // Image container
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],),
    );
  }
}
/*ToppingCard end here*/

/*CartItemCard start here*/
class CartItemCard   extends StatelessWidget {
const  CartItemCard ({super.key, required this.item,required this.cartProvider});

final Items item;
final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        cartProvider.removeItem(item);
      },
      key: ValueKey(item.name),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
       // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: item.image!=null && item.image!.isNotEmpty?Image.network(item.image!,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFF5F6FA),
                ),
                height: 100,
                width: 100,
                child: const Icon(
                  Icons.fastfood,
                  color: Colors.grey,
                  size: 35,
                ),
              ),
            ):const Icon(
              Icons.fastfood,
              color: Colors.grey,
              size: 35,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                item.name ?? 'Food Item',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "\$${(item.price??0).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                quantityButton(icon: Icons.remove, onPressed: (){
                  cartProvider.decreaseQty(item);
                }),
                SizedBox(
                  width: 35,
                  child: Center(
                    child: Text(
                      item.qty.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),),
                  ),
                ),
                quantityButton(icon: Icons.add, onPressed: (){
                  cartProvider.increaseQty(item);
                }),
              ],),
                const SizedBox(height: 5,),
            ],),
          ),
        ],),
      ),
    );
  }
}

/*CartItemCard end here*/
/*quantityButton start here*/
Widget quantityButton({
  required IconData icon,
  required VoidCallback onPressed}
    ) {
  return Material(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap:onPressed,
      child: SizedBox(
        height: 30,
        width: 30,
        child: Icon(icon,size: 17,color: AppColors.white ),),
    ),
  );
}
/*quantityButton end here*/