import 'package:flutter/material.dart';
import 'package:apartments_manager_main/utils/color_constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect(
      {super.key,
      required this.height,
      required this.width,
      required this.radius,
      this.colorr});
  final double height, width, radius;
  final Color? colorr;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 19, 18, 18),
      highlightColor: Colors.grey[200]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: colorr ?? ColorConstants.primaryWhiteColor,
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
