import 'dart:ui';

import 'package:dog_appnation/pages/home/dog_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = 8; // how many breeds
    return Container(
      color: Colors.white,
      child: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16+kBottomNavigationBarHeight*1.75+kBottomNavigationBarHeight*1.15, left: 16, right: 16, top: 16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: List.generate(
            itemCount,
            (index) => const DogContainer()),
      ),
    );
  }
}
