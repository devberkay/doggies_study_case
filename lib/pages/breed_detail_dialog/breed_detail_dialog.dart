import 'dart:io';

import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/service/dog_image_bloc.dart';
import 'package:dog_appnation/service/path_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

class BreedDetailDialog extends StatelessWidget {
  const BreedDetailDialog({super.key, required this.dogBreedModel});
  final DogBreedModel dogBreedModel;

  List<Widget> maybeSubBreedsBuilder(double fontSize) {
    if (dogBreedModel.subBreeds.isNotEmpty) {
      return List.generate(dogBreedModel.subBreeds.length * 2 - 1, (index) {
        if (index % 2 == 0) {
          return Text(
            dogBreedModel.subBreeds[index ~/ 2],
            style: TextStyle(
                fontFamily: "Galano Grotesque",
                decoration: TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: fontSize),
          );
        } else {
          return const SizedBox(
            height: 4,
          );
        }
      });
    } else {
      return [
        Text(
          "None",
          style: TextStyle(
              fontFamily: "Galano Grotesque",
              decoration: TextDecoration.none,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final imgTempDirPath =
        "${PathSingleton().appDir}/${path.basename(dogBreedModel.imageUrl)}";
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          DogImageBloc(),
          lazy: false,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: kBottomNavigationBarHeight * 1.55,
            top: kBottomNavigationBarHeight * 1.95,
            right: 16,
            left: 16), // to exactly match the figma margins
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Scrollbar(
            child: SingleChildScrollView(
              // physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: Image.file(
                          File(imgTempDirPath),
                          height: constraints.maxWidth,
                          width: constraints.maxWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        top: 8,
                        right: 8,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Breed",
                    style: TextStyle(
                        fontFamily: "Galano Grotesque",
                        decoration: TextDecoration.none,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxHeight * 0.036),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                    decoration: const ShapeDecoration(
                        shape: StadiumBorder(), color: Color(0xffF2F2F7)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dogBreedModel.breed,
                    style: TextStyle(
                        fontFamily: "Galano Grotesque",
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: constraints.maxHeight * 0.03),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Sub Breed",
                    style: TextStyle(
                        fontFamily: "Galano Grotesque",
                        decoration: TextDecoration.none,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxHeight * 0.036),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                    decoration: const ShapeDecoration(
                        shape: StadiumBorder(), color: Color(0xffF2F2F7)),
                  ),
                  const SizedBox(height: 8),
                  ...maybeSubBreedsBuilder(constraints.maxHeight * 0.03),
                  const SizedBox(height: 32),
                  BlocConsumer<DogImageBloc, DogImageBlocState?>(
                      listener: (context, state) {

                        debugPrint("newDogImageBloc state-listener: $state");
                        if (state is DogImageData) {
                          debugPrint("url ready: ${state.imgUrl}");
                          context.goNamed("generatedImageDialog",
                              extra: state.imgUrl);
                        }
                      },
                      
                      builder: (context, state) {
                        debugPrint("newDogImageBloc state-builder: $state");
                        final isLoading = state is DogImageLoading;
                        return CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: isLoading
                                ? null
                                : () {
                                    context
                                        .read<DogImageBloc>()
                                        .add(GenerateButtonPressed(dogBreed: dogBreedModel.breed));
                                  },
                            child: Container(
                              height: constraints.maxHeight * 0.09,
                              width: constraints.maxWidth * 0.85,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xff0085FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                      
                                    )
                                  : Text(
                                      "Generate",
                                      style: TextStyle(
                                          fontFamily: "Galano Grotesque",
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              constraints.maxHeight * 0.033),
                                    ),
                            ));
                      }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
