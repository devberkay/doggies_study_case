import 'dart:io';
import 'dart:ui';

import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/service/path_singleton.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class DogContainer extends StatelessWidget {
  const DogContainer({super.key, required this.dogBreedModel});
  final DogBreedModel dogBreedModel;

  @override
  Widget build(BuildContext context) {
    final imgTempDirPath =
        "${PathSingleton().appDir}/${path.basename(dogBreedModel.imageUrl)}";
    
    return GestureDetector(
      onTap: () {
        debugPrint("dogContainer pressed");
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: RepaintBoundary(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(imgTempDirPath),
                        fit: BoxFit
                            .fill, // assuming server provides 1:1 pics but still thinking the worst case, fill is a good choice for the sake of pattern preservence
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("dog_placeholder.png");
                        },
                      )),
                ),
              );
            }),
            Positioned(
              bottom: 0,
              left: 0,
              height: constraints.maxHeight * 0.2,
              width: constraints.maxWidth * 0.45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RepaintBoundary(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(12),
                      ),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 0.5),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.24),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(dogBreedModel.breed,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
