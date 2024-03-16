import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/pages/breed_detail_dialog/breed_detail_dialog.dart';
import 'package:dog_appnation/pages/common/dialog_route_page.dart';
import 'package:dog_appnation/pages/generated_image_dialog/generated_image_dialog.dart';
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
                      path: "breedDetailDialog",
                      name: "breedDetailDialog",
                      parentNavigatorKey: _rootNavigator,
                      pageBuilder: (context, state) => DialogRoutePage(
                            key: state.pageKey,
                            barrierDismissible: true,
                            pageBuilder:
                                (context, animationEntry, animationExit) {
                              return BreedDetailDialog(
                                  dogBreedModel: state.extra as DogBreedModel);
                            },
                            transitionBuilder: (context, animationEntry,
                                animationExit, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              final offsetAnimation =
                                  animationEntry.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                      routes: [
                        GoRoute(
                          path: "generatedImageDialog",
                          name: "generatedImageDialog",
                          parentNavigatorKey: _rootNavigator,
                          pageBuilder: (context, state) => DialogRoutePage(
                            key: state.pageKey,
                            barrierDismissible: true,
                            pageBuilder:
                                (context, animationEntry, animationExit) {
                              return GeneratedImageDialog(
                                  imgUrl: state.extra as String);
                            },
                            transitionBuilder: (context, animationEntry,
                                animationExit, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              final offsetAnimation =
                                  animationEntry.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        ),
                      ]),
                  GoRoute(
                    path: "inputModal",
                    name: "inputModal",
                    pageBuilder: (context, state) => ModalSheetPage(
                        key: state.pageKey,
                        barrierDismissible: true,
                        barrierColor: Colors.transparent,
                        barrierLabel: "inputModalBarrier",
                        child: InputModal(
                          textController: state.extra as TextEditingController,
                        )),
                  ),
                  GoRoute(
                      path: "settings",
                      name: "settings",
                      parentNavigatorKey: _rootNavigator,
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
