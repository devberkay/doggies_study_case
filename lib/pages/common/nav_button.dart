import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton(
      {super.key,
      required this.activeIcon,
      required this.icon,
      required this.title,
      required this.isActive,
      required this.onTap});
  final IconData icon;
  final IconData activeIcon;
  final String title;
  final bool isActive;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final shouldRotate = icon ==
        Icons
            .build_outlined; // It's because in figma we have icon placed towards 14:00 direction
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: shouldRotate ? -pi * 3 / 2 : 0,
            child: Icon(isActive ? activeIcon : icon,
                color: isActive ? primary : Colors.black),
          ),
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isActive ? primary : Colors.black))
        ],
      ),
    );
  }
}
