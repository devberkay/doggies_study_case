import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class InputModal extends StatefulWidget {
  const InputModal({super.key, required this.textController});
  final TextEditingController textController;

  @override
  State<InputModal> createState() => _InputModalState();
}

class _InputModalState extends State<InputModal> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      
      maxExtent: Extent.proportional(1),
      initialExtent: Extent.proportional(0.15),
      minExtent: Extent.proportional(0.15),
      child: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 3,
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: Color(0xffE5E5EA),
              ),
            ),
            CupertinoTextField.borderless(
              placeholder: "Search",
              controller: widget.textController,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                context.pop();
              },
              focusNode: _focusNode,
              style: TextStyle(
                  fontFamily: "Galano Grotesque",
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              placeholderStyle: TextStyle(
                  fontFamily: "Galano Grotesque",
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3C3C43).withOpacity(0.7)),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
