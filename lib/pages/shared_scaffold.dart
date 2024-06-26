import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/pages/common/custom_nav_bar.dart';
import 'package:dog_appnation/pages/common/floating_search_button.dart';
import 'package:dog_appnation/pages/common/nav_bar_painter.dart';
import 'package:dog_appnation/pages/common/scroll_custom_behavior.dart';
import 'package:dog_appnation/service/dog_breed_bloc.dart';
import 'package:dog_appnation/service/dog_image_bloc.dart';
import 'package:dog_appnation/service/dog_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
    final isDialog = widget.routerState.fullPath?.contains("Dialog") ?? false;
    final isInputModal =
        widget.routerState.fullPath?.contains("inputModal") ?? false;
    final navBarIndex = isSettings ? 1 : 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider<DogBreedBloc>(
          create: (context) => DogBreedBloc()..add(AppInitializing()),
        ),
        BlocProvider<DogSearchBloc>(
          create: (context) => DogSearchBloc(),
        )
      ],
      child: BlocListener<DogBreedBloc, DogBreedBlocState>(
        listener: (context, state) {
          if (state is DogBreedLoading) {
            debugPrint("DogBreedLoading");
          } else if (state is DogBreedData) {
            debugPrint("DogBreedData: ${state.breeds.length}");
            if (state.breeds.isNotEmpty) {
              FlutterNativeSplash.remove();
            }
          } else if (state is DogBreedError) {
            debugPrint("DogBreedError: ${state.error}\n\n ${state.stackTrace}");
            context
                .read<DogBreedBloc>()
                .add(AppInitializing()); // try fetching again
          }
        },
        // bloc: DogBreedBloc(),
        child: Scaffold(
          extendBody: true, // !isInputModal
          backgroundColor: Colors.white,
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: widget.child,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
            centerTitle: true,
            title: const Text(
              "Doggnation",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
