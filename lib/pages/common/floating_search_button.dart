import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingSearchButton extends StatefulWidget {
  const FloatingSearchButton({super.key,required this.textController});
  final TextEditingController textController;

  @override
  State<FloatingSearchButton> createState() => _FloatingSearchButtonState();
}

class _FloatingSearchButtonState extends State<FloatingSearchButton> {
  

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: kBottomNavigationBarHeight * 1.1,
        child: CupertinoTextField(
          placeholder: "Search",
          controller: widget.textController,
          readOnly: true,
          onTap: () {
            context.goNamed("inputModal", extra: widget.textController);
          },
          style: TextStyle(
              fontFamily: "Galano Grotesque",
              fontWeight: FontWeight.w600,
              color: Color(0xff3C3C43).withOpacity(0.7)),
          placeholderStyle: TextStyle(
              fontFamily: "Galano Grotesque", fontWeight: FontWeight.w600),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 5,
                  spreadRadius: 1,
                  blurStyle: BlurStyle.outer,
                )
              ],
              border: Border.all(color: Color(0xffE5E5EA), width: 2)),
        ),
      ),
    );
  }
}
