import 'package:dog_appnation/pages/home/home_page.dart';
import 'package:dog_appnation/pages/input_modal/input_modal.dart';
import 'package:dog_appnation/pages/settings_modal/settings_page.dart';
import 'package:dog_appnation/pages/shared_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import 'package:smooth_sheets/smooth_sheets.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class GoRouterSingleton {
  late final GoRouter _goRouterInstance;

  factory GoRouterSingleton() {
    return _instance;
  }

  GoRouterSingleton._singletonContractor() {
    final isAndroid = Platform.isAndroid;
    _goRouterInstance = GoRouter(
      initialLocation: "/",
      navigatorKey: _rootNavigator,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigator,
          pageBuilder: ((context, state, child) {
            return MaterialPage(
              key: state.pageKey,
              child: SharedScaffold(
                key: state.pageKey,
                routerState: state,
                child: child,
              ),
            );
          }),
          routes: [
            GoRoute(
                path: "/",
                name: "home",
                pageBuilder: (context, state) => isAndroid
                    ? MaterialPage(
                        key: state.pageKey,
                        child: HomePage(
                          key: state.pageKey,
                        ))
                    : CupertinoPage(
                        key: state.pageKey,
                        child: HomePage(
                          key: state.pageKey,
                        )),
                routes: [
                  GoRoute(
                      path: "inputModal",
                      name: "inputModal",
                      pageBuilder: (context, state) => ModalSheetPage(
                          key: state.pageKey,
                          barrierDismissible: true,
                          maintainState: false,
                          child: InputModal(
                            textController:
                                state.extra as TextEditingController,
                          )),
                      ),
                  GoRoute(
                            path: "settings",
                            name: "settings",
                            pageBuilder: (context, state) => ModalSheetPage(
                                key: state.pageKey,
                                barrierColor: Colors.transparent,
                                barrierDismissible: true,
                                child: SheetDismissible(
                                  onDismiss: () {
                                    
                                    return true;
                                  },
                                  child: const SettingsModal(),
                                )))
                ]),
          ],
        ),
      ],
    );
  }

  GoRouter get getInstance => _goRouterInstance;

  static final GoRouterSingleton _instance =
      GoRouterSingleton._singletonContractor();
}
