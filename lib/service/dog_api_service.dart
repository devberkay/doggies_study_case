import 'dart:convert';
import 'dart:io';

import 'package:dog_appnation/model/api/api_dog_breed_response_model.dart';
import 'package:dog_appnation/model/api/api_img_response_model.dart';
import 'package:http/http.dart' as http;

class DogApiService {
  Future<Map<String, List<String>>> fetchDogBreeds() async {
    // and its subbreeds
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
    final apiResponse = ApiDogBreedResponseModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200 && apiResponse.status == 'success') {
      return apiResponse.message;
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<String> fetchDogImage(String breed) async {
    final response = await http
        .get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
    final apiResponse = ApiImgResponseModel.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200 && apiResponse.status == 'success') {
      return apiResponse.message;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw HttpException(response.statusCode.toString());
    }
  }
}
