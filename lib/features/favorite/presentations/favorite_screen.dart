import 'package:flutter/material.dart';
import 'package:food_rush/features/favorite/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_strings.dart';
import '../../detail/presentations/widgets/circle_button.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Consumer<FavoriteProvider>(
            builder: (context, favProvider, child) {
              final favItems = favProvider.favItems;

              if (favItems.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 56,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No favorites yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap the heart on any food to save it here',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return  Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                  ), itemBuilder: (context, index) {
                  final item= favItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:[
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: Offset(0, 4),),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),),
                              child: Image.network(item.image??"",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F6FA),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child:  Center(child: Icon(Icons.fastfood_rounded,size: 40,color: Colors.grey,),),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,),
                                  child: Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
                                    final isFav=favProvider.isFavorite(item);
                                    return  IconButton(onPressed: () {
                                      favProvider.toggleFavorite(item);
                                    }, icon: Icon(isFav?Icons.favorite:Icons.favorite_border, color: isFav?Colors.red:Colors.grey, size: 18,),);
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),),
                              const SizedBox(height: 3,),
                              Text(item.description ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff777777),
                                ),
                              ),
                              const SizedBox(height: 3,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.price,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${item.price}",
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],),
                            ],),
                        ),
                      ],),
                  );
                },),);
            },
          ),
          /*second portion end here*/
        ],),
      ),
    );
  }
}
