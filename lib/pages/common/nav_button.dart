import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.activeIcon, required this.icon,required this.title,required this.onTap});
  final IconData icon;
  final IconData activeIcon;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final isActive = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          isActive ? activeIcon : icon,
          color: isActive ? primary : Colors.black
          
        ),
        Text(title,style: TextStyle(fontWeight: FontWeight.w600,color: isActive ? primary : Colors.black))
      ],
    );
  }
}
