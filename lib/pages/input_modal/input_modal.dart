import 'dart:async';
import 'dart:developer';

import 'package:dog_appnation/service/dog_search_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final SheetController _sheetController;
  late final ValueNotifier<double> _proportionVN;
  final GlobalKey _textFieldKey = GlobalKey();
  late final void Function() _sheetListener;
  double? _previousHeight;
  late Timer _timer;

  @override
  void initState() {
    _proportionVN = ValueNotifier(0.15);
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _sheetController = SheetController();
    _sheetListener = () {
      log("_sheetController-value: ${_sheetController.value}, _proportionVN-value: ${_proportionVN.value}, metrics: ${_sheetController.metrics!.maxPixels}, metrics-2: ${_sheetController.metrics!.viewportDimensions.height},metrics-3: ${_sheetController.metrics!.minPixels}");
      if (context.mounted && _sheetController.value?.toInt() == _sheetController.metrics?.minPixels.toInt()) {
        _proportionVN.value = 0.15;
      }
    };
    _sheetController.addListener(_sheetListener);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _checkHeight();
    });

    super.initState();
  }

  @override
  void dispose() {
    _proportionVN.dispose();
    _timer.cancel();
    _focusNode.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _checkHeight() {
    final RenderBox renderBox =
        _textFieldKey.currentContext?.findRenderObject() as RenderBox;
    final currentHeight = renderBox.size.height;
    if (_previousHeight != null &&
        currentHeight != _previousHeight &&
        mounted &&
        currentHeight > _previousHeight! &&
        _proportionVN.value == 0.15) {
      _proportionVN.value = 1;
      
      _sheetController
          .animateTo(Extent.proportional(_proportionVN.value),
              )
          .then((value) {
        
      });
    }
    _previousHeight = currentHeight;
  }

  @override
  Widget build(BuildContext context) {
    final usableHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).viewInsets.bottom;

    return DraggableSheet(
      controller: _sheetController,
      maxExtent: const Extent.proportional(1),
      initialExtent: const Extent.proportional(0.15),
      minExtent: const Extent.proportional(0.15),
      physics: StretchingSheetPhysics(
        stretchingRange: const Extent.proportional(0.85),
        parent: SnappingSheetPhysics(
          snappingBehavior: SnapToNearest(
            snapTo: [
              const Extent.proportional(0.15),
              const Extent.proportional(1),
            ],
          ),
        ),
      ),
      child: Container(
        height: usableHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE5E5EA), width: 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(8),
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
            CupertinoTextField.borderless(
              key: _textFieldKey,
              autocorrect: false,
              enableSuggestions: false,
              placeholder: "Search",
              maxLines: null,
              onTapOutside: (event) {},
              onChanged: (value) {
                context
                    .read<DogSearchBloc>()
                    .add(onTextChanged(newText: value));
              },
              controller: widget.textController,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                context.pop();
              },
              focusNode: _focusNode,
              style: const TextStyle(
                  fontFamily: "Galano Grotesque",
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              placeholderStyle: TextStyle(
                  fontFamily: "Galano Grotesque",
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff3C3C43).withOpacity(0.7)),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
