import 'dart:convert';
import 'package:dog_appnation/model/api/api_dog_breed_response_model.dart';
import 'package:dog_appnation/model/api/api_img_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DogApiService {
  // Private constructor
  DogApiService._privateConstructor();

  // Static private instance of the class
  static final DogApiService _instance = DogApiService._privateConstructor();

  // Factory constructor to return the same instance
  factory DogApiService() {
    return _instance;
  }

  Future<Map<String, List<String>>> fetchDogBreeds() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
    final apiResponse = ApiDogBreedResponseModel.fromJson(response.body);
    if (response.statusCode == 200 && apiResponse.status == 'success') {
      debugPrint("dogBreeds Fetched successfully");
      return apiResponse.message;
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<String> fetchDogImage(String breed) async {
    final response = await http
        .get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
    final apiResponse = ApiImgResponseModel.fromJson(response.body);

    if (response.statusCode == 200 && apiResponse.status == 'success') {
      return apiResponse.message;
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }
}

// Usage:
// DogApiService dogApiService = DogApiService();
