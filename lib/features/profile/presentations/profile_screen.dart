import 'package:flutter/material.dart';
import 'package:food_rush/core/constant/app_strings.dart';
import 'package:food_rush/features/detail/presentations/widgets/circle_button.dart';
import 'package:food_rush/features/favorite/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/app_colors.dart';
import '../../cart/providers/cart_provider.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            /*first portion start here*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                CircleButton(icon: Icons.arrow_back,onTap: (){
                  Navigator.pop(context);
                },),
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                CircleButton(icon: Icons.settings_outlined),
              ],),
            ),
            /*first portion end here*/
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              child: Column(children: [
                /*header start here*/
                ProfileHeader(),
                /*header end here*/
                const SizedBox(height: 16),
                /*_StatsRow*/
                _StatsRow(),
                /*_StatsRow*/
               const SizedBox(height: 12,),
                ProfileOptionTile(icon: Icons.shopping_bag_outlined, title:"My Orders", subtitle: "View your order history"),
                const SizedBox(height: 12,),
                ProfileOptionTile(icon: Icons.location_on_outlined, title: 'My Addresses', subtitle: 'Manage delivery addresses',),
                const SizedBox(height: 12,),
                ProfileOptionTile(icon: Icons.favorite_border, title: 'My Favorites', subtitle: 'Your favorite food items',),
                const SizedBox(height: 12,),
                ProfileOptionTile(icon: Icons.payment_outlined, title: 'Payment Methods', subtitle: 'Manage your payment options',),
                const SizedBox(height: 12,),
                ProfileOptionTile(icon: Icons.help_outline, title: 'Help & Support', subtitle: 'Get assistance with your orders',),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 52, width: double.infinity,
                  child:
                OutlinedButton.icon(style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ), side: BorderSide(color:   AppColors.primary,),),
                  onPressed: (){}, icon: Icon(Icons.logout_rounded), label:  const Text('Log out', style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700,),),),
                ),
              ],),
            ),
          ],),
        ),
      ),
    );
  }
}
// ProfileHeader
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.30),
            blurRadius: 18,
            offset: const Offset(0, 3),
          ),
        ],
gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.primary1, AppColors.primary],
),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white.withOpacity(0.25),
            child:  Text(AppStrings.appName[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                "Nabil",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
               "mohammad.nabil.ashraf@gmail.com",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
                const SizedBox(height: 2),
                Text(
                  "+923002517260",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
            ],),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.white,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              child: const SizedBox(
                height: 38,
                width: 38,
                child: Icon(Icons.edit_outlined,size: 18, color: AppColors.primary),),
            ),
          ),
        ],
      ),
    );
  }
}
// ProfileHeader
/*_StatsRow start here*/
class _StatsRow  extends StatelessWidget {
  const _StatsRow ({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider= context.watch<CartProvider>();
    final favProvider= context.watch<FavoriteProvider>();
    return Row(children: [
_StatCard(value: cartProvider.items.length.toString(), label: "Orders"),
      const SizedBox(width: 12),
      _StatCard(value: favProvider.favItems.length.toString(), label: "Favorites"),
      const SizedBox(width: 12),
      _StatCard(value: '4', label: 'Points'),
    ],);
  }
}

/*_StatsRow end here*/
/*_StatCard start here*/
class _StatCard  extends StatelessWidget {
  const _StatCard ({super.key,required this.value,required this.label});
  final String   value, label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2,),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],),
      ),
    );
  }
}

/*_StatCard end here*/
/*ProfileOptionTile*/
class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({super.key,required this.icon,required this.title,required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Container(height: 44,width: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22,),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],),
          ),
          Icon(Icons.chevron_right,
            color: Colors.grey.shade500,),
        ],),
      ),
    );
  }
}

/*ProfileOptionTile*/