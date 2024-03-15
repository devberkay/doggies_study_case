import 'package:dog_appnation/pages/common/custom_nav_bar.dart';
import 'package:dog_appnation/pages/common/floating_search_button.dart';
import 'package:dog_appnation/pages/common/nav_bar_painter.dart';
import 'package:dog_appnation/pages/common/scroll_custom_behavior.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedScaffold extends StatefulWidget {
  const SharedScaffold(
      {super.key, required this.child, required this.routerState});
  final Widget child;
  final GoRouterState routerState;

  @override
  State<SharedScaffold> createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends State<SharedScaffold> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(); // won't be disposed.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    debugPrint("routerState-fullPath: ${widget.routerState.fullPath}");
    final isHome = widget.routerState.fullPath == "/";
    final isSettings = widget.routerState.fullPath == "/settings";
    final navBarIndex = isSettings ? 1 : 0;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: widget.child,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isHome
          ? FloatingSearchButton(
              textController: _textEditingController,
            )
          : null,
      bottomNavigationBar: isSettings
          ? null
          : SizedBox(
              height: kBottomNavigationBarHeight * 1.75,
              width: double.maxFinite,
              child: CustomNavBar(navBarIndex: navBarIndex)),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Doggnation",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
