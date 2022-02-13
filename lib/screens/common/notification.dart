import 'package:flutter/material.dart';

class AlertNotification extends StatelessWidget {
  final String text;
  final Widget? icon;
  final LinearGradient? gradient;
  final Color? textColor;

  const AlertNotification({
    Key? key,
    required this.text,
    this.icon,
    this.gradient,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: gradient,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              icon ?? Container(),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
