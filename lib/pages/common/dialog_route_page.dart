import 'package:flutter/material.dart';

/// A dialog page with Material entrance and exit animations, modal barrier color,
/// and modal barrier behavior (dialog is dismissible with a tap on the barrier).
class DialogRoutePage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final Duration transitionDuration;
  final Widget Function(
          BuildContext, Animation<double>, Animation<double>, Widget)?
      transitionBuilder;
  final Widget Function(BuildContext, Animation<double>, Animation<double>)
      pageBuilder;
  const DialogRoutePage({
    required this.pageBuilder,
    this.transitionBuilder = _defaultTransitionBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.anchorPoint,
    this.barrierColor = const Color.fromRGBO(35, 35, 35, 0.75),
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = false,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  // Define a default transition builder function.
  static Widget _defaultTransitionBuilder(
      context, animation1, animation2, child) {
    return FadeTransition(
      opacity: animation1,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation1,
          curve: Curves.easeOutBack,
        )),
        child: child,
      ),
    );
  }

  @override
  Route<T> createRoute(BuildContext context) => RawDialogRoute<T>(
        pageBuilder: pageBuilder,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        settings: this,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
      );
}
