import 'package:dog_appnation/pages/common/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                child: NavButton(
              activeIcon: Icons.home_filled,
              icon: Icons.home,
              title: "Home",
              onTap: () {
                context.goNamed("home");
              },
            )),
            Container(
              width: 2,
            ),
            Expanded(
                child: NavButton(
                    activeIcon: Icons.home_filled,
                    icon: Icons.home,
                    title: "Settings",onTap: () {
                      context.goNamed("settings");
                    },)),
          ],
        ));
  }
}
