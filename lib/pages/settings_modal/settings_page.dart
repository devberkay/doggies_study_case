import 'dart:math';

import 'package:dog_appnation/service/os_version_service.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "Help",
      "Rate us",
      "Share with Friends",
      "Terms of Use",
      "Privacy Policy",
      "OS Version",
    ];
    final List<IconData> icons = [
      Icons.info_outline,
      Icons.star_outline,
      Icons.ios_share_outlined,
      Icons.receipt_long_outlined,
      Icons.verified_user_outlined,
      Icons.usb_outlined,
    ];
    final usableHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.transparent,
      child: DraggableSheet(
        child: Container(
          height: usableHeight,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Color(0xffF2F2F7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 3,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xffE5E5EA),
                ),
              ),
              const SizedBox(height: 32),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    final isOsVersionTile = index == 5;
                    return ListTile(
                      leading: Icon(icons[index], color: Colors.black),
                      title: Text(titles[index],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: !isOsVersionTile
                          ? Transform.rotate(
                              angle: pi * 1 / 4,
                              child: const Icon(
                                Icons.arrow_upward,
                                color: Color(0xffC7C7CC),
                              ))
                          : Text(
                              "${OsVersionService().osVersion}",
                              style: TextStyle(
                                  color: Color(0xffC7C7CC),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                      onTap: () {
                        debugPrint("tapped ${index}");
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 2,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: const ShapeDecoration(
                          shape: StadiumBorder(), color: Color(0xffE5E5EA)),
                    );
                  },
                  itemCount: 6),
            ],
          ),
        ),
      ),
    );
  }
}
