import 'package:dog_appnation/pages/common/nav_bar_painter.dart';
import 'package:dog_appnation/pages/common/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.navBarIndex});
  final int navBarIndex;
  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late final TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
          painter: NavbarPainter(),
          isComplex: true,
          size: Size(double.maxFinite, kBottomNavigationBarHeight * 1.75),
          child: Row(
            children: [
              Expanded(
                  child: NavButton(
                activeIcon: Icons.home_filled,
                icon: Icons.home_outlined,
                isActive: widget.navBarIndex == 0,
                title: "Home",
                onTap: () {
                  debugPrint("go to settings");
                  context.goNamed("home");
                },
              )),
              Container(
                width: 2,
                height: kBottomNavigationBarHeight / 2,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xFFD1D1D6),
                ),
              ),
              Expanded(
                  child: NavButton(
                      activeIcon: Icons.build_sharp,
                      icon: Icons.build_outlined,
                      isActive: widget.navBarIndex == 1,
                      title: "Settings",
                      onTap: () {
                        debugPrint("go to settings");
                        context.goNamed("settings");
                      })),
            ],
          )),
    );
  }
}
