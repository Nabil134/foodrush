import 'package:flutter/material.dart';
import 'package:food_rush/features/cart/presentations/cart_screen.dart';
import 'package:food_rush/features/category/providers/category_provider.dart';
import 'package:food_rush/features/detail/presentations/widgets/circle_button.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../../cart/providers/cart_provider.dart';
import '../../category/models/category_model.dart';
import '../providers/detail_provider.dart';

class  DetailScreen extends StatelessWidget {
  const  DetailScreen({super.key,required this.items});
  final Items items;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context) => DetailProvider(items: items),
      child: DetailView(),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView();

  @override
  Widget build(BuildContext context) {
    final detailProvider= context.watch<DetailProvider>();
    final categoryProvider= context.watch<CategoryProvider>();
    final items=detailProvider.items;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      /* bottomNavigationBar start here*/
      bottomNavigationBar:  Container(
        padding:  EdgeInsets.fromLTRB(
          14,
          14,
          14,
          MediaQuery.of(context).padding.bottom+14,
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
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child:  Center(
              child: Text(
                '\$${detailProvider.totalPrice.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(onPressed: (){
                final cartProvider = context.read<CartProvider>();
                cartProvider.addItem(detailProvider.items, qty: detailProvider.quantity);
                _orderNow(context, detailProvider);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),),);
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF302B2B),
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
      ),
      /* bottomNavigationBar end here*/
      backgroundColor:  AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  categoryProvider.clearSearch();
                },
              ),
              CircleButton(
                icon: Icons.search,
              ),
            ],),
          ),
          /*first portion end here*/
          /*second portion start here*/
          Center(
            child: SizedBox(
              height: size.height * 0.28,
              width: double.infinity,
              child: items.image!.isNotEmpty && items.image!=null?Image.network(items.image??"",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.fastfood,
                    size: 100,
                    color: Colors.grey,
                  ),
                );
              },):Icon(
                Icons.fastfood,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          /*second portion end here*/
          /*third portion start here*/
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items.name ?? 'Food Item',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),),
                const SizedBox(height: 6),
                Text(
                  items.description ?? 'No Description',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF777777),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${items.price?.toStringAsFixed(2)??"0.0"}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),),
                    Text(
                      '/ item',
                      style:  TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),),
                  ],
                ),
              ],
            ),
          ),
          /*third portion end here*/
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey.shade100,
              thickness: 1.5,
              indent: 18,
              endIndent: 18,
            ),
            const SizedBox(height: 14),
            /*four portion start here*/
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Expanded(
                child: _spicySection(context, detailProvider),),
                const SizedBox(width: 16,),
                portionSection(detailProvider),
            ],),
            /*four portion end here*/
            /*last portion start here*/

            /*last portion end here*/

          ],),
      ),
    );
  }
/*portionSection start here*/
  Widget portionSection(DetailProvider detailProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      "Portion",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      child: Row(children: [
  quantityButton(
      icon: Icons.remove,
      onPressed: (){
        detailProvider.decreaseQty();
      },
  ),
                        SizedBox(
                          width: 38,
                          child: Center(
                            child: Text(
                              detailProvider.quantity.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),),
                          ),
                        ),
                        quantityButton(
                          icon: Icons.add,
                          onPressed: (){
                            detailProvider.increaseQty();
                          },
                        ),

                      ],),
                    ),
                  ],),
    );
  }
  /*portionSection end here*/
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
  /*spicySection start here*/
  Widget _spicySection(BuildContext context, DetailProvider detailProvider) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Spicy Level",
                  style: const TextStyle(
                    fontSize: 14,
                    color:   AppColors.black,
                    fontWeight: FontWeight.w600,),),
              ),
              const SizedBox(height: 6,),
              SliderTheme(data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
                trackHeight: 4,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.primary.withOpacity(0.15),
                thumbColor: AppColors.primary,
                overlayColor:
                AppColors.primary.withOpacity(0.10),
              ), child: Slider(
                value: detailProvider.spicyLevel,
                min: 0,
                max: 1,
                onChanged: detailProvider.changeSpicyLevel,
              ),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Mild 🌿",
                      style: const TextStyle(
                        fontSize: 12,
                        color:   AppColors.greenColor,
                        fontWeight: FontWeight.w500,),),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          detailProvider.spicyText,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                    Text(
                      "🌶 Hot",
                      style: const TextStyle(
                        fontSize: 12,
                        color:   AppColors.primary,
                        fontWeight: FontWeight.w500,),),
                  ],),
                ),
            ],);
  }
/*spicySection end here*/
/*_orderNow start here*/
void _orderNow (BuildContext context ,DetailProvider provider){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primary,
      margin: const EdgeInsets.all(16),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10,),
          Text("${provider.items.name} added to order"),
        ],
      ),),);

}
/*_orderNow end here*/
}

