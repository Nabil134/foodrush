import 'package:flutter/material.dart';
import 'package:food_rush/components/LoadingCard.dart';
import 'package:food_rush/features/category/providers/category_provider.dart';
import 'package:food_rush/features/favorite/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/network/api_status.dart';
import '../../detail/presentations/detail_screen.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final homeProvider = context.read<HomeProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    homeProvider.initializeTabController(this,categoryProvider);
    categoryProvider.getCategory(homeProvider.categories[0]);
    super.initState();
  }
  @override
  void dispose() {
    context.read<HomeProvider>().disposeTabController();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final homeProvider= context.watch<HomeProvider>();
    final categoryProvider= context.watch<CategoryProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
/*first portion start here*/
            ValueListenableBuilder(valueListenable: categoryProvider.searchController,
            builder:(context, value, child) =>value.text.isEmpty?
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Image.asset(AppImages.logo,color: AppColors.black,),
                  Text(
                    AppStrings.orderYourFavouriteFood,
                    style: TextStyle(
                      color: Color(0xFF6A6A6A),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(AppImages.profile),
              ),
            ],),
          ):SizedBox.shrink(),),
            /*first portion end here*/
            const SizedBox(height: 40,),
            /*second portion start here*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only( left: 10),
                   // height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.07),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ValueListenableBuilder(valueListenable: categoryProvider.searchController,
                          builder:(context, value, child) =>value.text.isEmpty? Icon(Icons.search): const SizedBox(),),
                        Expanded(
                          child: TextField(
                            controller: categoryProvider.searchController,
                            onChanged: categoryProvider.searchProducts,
                            decoration: InputDecoration(
                              suffixIcon:ValueListenableBuilder(valueListenable: categoryProvider.searchController,
                                builder:(context, value, child) =>value.text.isNotEmpty? IconButton(icon:Icon(Icons.close),onPressed: (){
                                  categoryProvider.clearSearch();
                                },):SizedBox(),),
                              contentPadding: EdgeInsets.all(8),
                              filled: true,
                              fillColor: AppColors.white,
                              hintText: "Search",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
      ValueListenableBuilder(valueListenable: categoryProvider.searchController,
        builder:(context, value, child) =>value.text.isEmpty?
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color:AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.tune,color:AppColors.white,),
                ):SizedBox(),),
              ],),
            ),
            /*second portion end here*/
            const SizedBox(height: 20),
            /*third portion start  here*/
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TabBar(
                padding: EdgeInsets.zero,
                isScrollable: true,
                  labelPadding: const EdgeInsets.only(right: 8),
                  tabAlignment: TabAlignment.start,
                controller: homeProvider.tabController,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  tabs:
                  homeProvider.categories.asMap().entries.map((entry){
                    final index= entry.key;
                    final category= entry.value;
                    return _categoryTab(isSelected: homeProvider.tabIndex==index, title: category);
                  }).toList(),
              ),
            ),
            /*third portion end  here*/
            const SizedBox(height: 20),
            /*last portion start  here*/
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                  controller: homeProvider.tabController,
                  children: homeProvider.categories.map((e) => _buildCategory(categoryProvider)).toList(),
              ),
            ),
            /*last portion end  here*/
          ],),
        ),
      ),
    );
  }
}
/*_categoryTab start here*/
Widget _categoryTab({
    required bool isSelected,
  required String title
}
    ){
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10, ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isSelected?AppColors.primary:AppColors.lightGrey,
      boxShadow:isSelected? [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ]:null,
    ),
    child: Text(title,style: TextStyle(
      color: isSelected ? AppColors.white : AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500,
    ),),
  );
}
/*_categoryTab end here*/
/*_buildCategory start here*/
Widget  _buildCategory(CategoryProvider provider){
  final response=provider.categoryResponse;
  switch(response.status){
    case Status.idle:
      return Center(child:Text("No Category Loaded") ,);
    case Status.loading:
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: GridView.builder(
          itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
            ), itemBuilder: (context, index) {
              return LoadingCard();
            },),
      );
    case Status.error:
      return Center(child:Text(response.message??"Something went wrong"),);
    case Status.completed:
      final category= provider.categoryResponse.data;
      if(category==null || category.items==null) {
        return Center(child: Text("Something went wrong"),);
      }
      final items=provider.filteredList;
      if(items.isEmpty){
        return Center(child: Text("No Food  Found "),);
      }
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
          ), itemBuilder: (context, index) {
final item= items[index];
return InkWell(
  onTap: (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(items: item),
      ),
    );
  },
  child:   Container(
    decoration: BoxDecoration(

      color: AppColors.white,

      borderRadius: BorderRadius.circular(20),

      boxShadow:[

        BoxShadow(

            color: AppColors.black.withOpacity(0.06),

            blurRadius: 12,

            offset: Offset(0, 4),

        ),

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

              topLeft: Radius.circular(20),

            ),

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

                  shape: BoxShape.circle,

                ),

                child: Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
                  final isFav=favProvider.isFavorite(item);
                 return  IconButton(onPressed: () {
                    favProvider.toggleFavorite(item);
                  }, icon: Icon(isFav?Icons.favorite:Icons.favorite_border, color: isFav?Colors.red:Colors.grey, size: 18,),);
                }
  ),

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

            ),

          ),

            const SizedBox(height: 3,),

            Text(

              item.description ?? '',

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

  ),
);
          },),);

  }
}
/*_buildCategory end here*/