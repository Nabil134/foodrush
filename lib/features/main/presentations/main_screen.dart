import 'package:flutter/material.dart';
import 'package:food_rush/core/constant/app_colors.dart';
import 'package:food_rush/features/main/providers/main_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainProvider>();
    final isKeyboard= MediaQuery.of(context).viewInsets.bottom>0;
    return Scaffold(
      body: provider.pages[provider.currentIndex],
      /*floatingActionButton start here*/
      floatingActionButton:isKeyboard?null: FloatingActionButton(
        shape: const CircleBorder(),
          elevation: 8,
          backgroundColor:AppColors.primary,
          onPressed: (){
      },
        child: Icon(Icons.add,color:AppColors.white,size: 32,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /*floatingActionButton end here*/
      /*bottomNavigationBar start here*/
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
elevation: 10,
color:AppColors.primary,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
navItem(context, icon: Icons.home_outlined, index: 0,selectedIcon: Icons.home),
            navItem(context, icon: Icons.person_outlined, index: 1,selectedIcon: Icons.person),
              const SizedBox(width: 55),
            navItem(context, icon: Icons.receipt_long_outlined, selectedIcon: Icons.receipt_long, index: 2,),
            navItem(context, icon: Icons.favorite_border, index: 3,selectedIcon: Icons.favorite),
          ],),
        ),
      ),
      /*bottomNavigationBar end here*/

    );
  }
  /*navItem start here*/
Widget navItem(BuildContext context,{
  required IconData icon,selectedIcon,
  required int index,
  }){
  final provider= context.watch<MainProvider>();
  final bool isSelected=provider.currentIndex==index;

  return GestureDetector(onTap: (){
    provider.changeIndex(index);
  },
    child: SizedBox(
      width: 55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
Icon(isSelected?selectedIcon:icon,color: AppColors.white,size: 27,),
        const SizedBox(height: 7,),
        if(isSelected)
        Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
              color: AppColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ],),
    ),
  );
}
/*navItem end here*/
}
