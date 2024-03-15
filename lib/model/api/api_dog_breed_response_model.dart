import 'dart:convert';

class ApiDogBreedResponseModel {
  final Map<String,List<String>> message;
  final String status;

  ApiDogBreedResponseModel({required this.message, required this.status});
  

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory ApiDogBreedResponseModel.fromMap(Map<String, dynamic> map) {
    return ApiDogBreedResponseModel(
      message: Map<String,List<String>>.from(map['message']),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiDogBreedResponseModel.fromJson(String source) => ApiDogBreedResponseModel.fromMap(json.decode(source));
}
