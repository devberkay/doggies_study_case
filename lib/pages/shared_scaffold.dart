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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: widget.child,
      ),
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Doggnation",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
