import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onTap,
    required this.icon,
  });
  final void Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap:onTap,
      child: SizedBox(
        height: 42,
        width: 42,
        child: Icon(icon,size: 19,color: AppColors.black ,),),
    );
  }
}
