import 'dart:convert';

import 'package:flutter/foundation.dart';

class DogBreedModel {
  String breed;
  List<String> subBreeds;
  String imageUrl;

  DogBreedModel({
    required this.breed,
    required this.subBreeds,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DogBreedModel &&
        other.breed == breed &&
        listEquals(other.subBreeds, subBreeds) &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(
        breed,
        Object.hashAll(subBreeds),
        imageUrl,
      );
}
