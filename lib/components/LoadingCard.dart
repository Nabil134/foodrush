import 'package:flutter/material.dart';
import 'package:food_rush/components/loading_continer.dart';
import '../core/constant/app_colors.dart';
class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ================= IMAGE ================= */
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: LoadingContainer(
              height: 120,
              width: double.infinity,
            ),
          ),
          /* ================= DETAILS ================= */
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ---------- Food Name ---------- */
                LoadingContainer(
                  height: 13,
                  width: 100,),
                const SizedBox(height: 6),

                /* ---------- Description ---------- */

                LoadingContainer(
                  height: 10,
                  width: 140,
                ),

                const SizedBox(height: 8),

                /* ---------- Price ---------- */

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    LoadingContainer(
                      height: 13,
                      width: 45,
                    ),

                    LoadingContainer(
                      height: 13,
                      width: 55,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}