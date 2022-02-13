import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropCard extends StatelessWidget {
  final String data;
  final String description;
  final Color? backgroundColor;
  final LinearGradient? gradient;
  final Color? textColor;
  final void Function()? onTap;

  const PropCard({
    Key? key,
    required this.data,
    required this.description,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? dataTheme = Get.textTheme.headline4?.copyWith(color: textColor);
    TextStyle? descTheme = Get.textTheme.headline6?.copyWith(color: textColor);

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data,
                  style: dataTheme,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: descTheme,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
