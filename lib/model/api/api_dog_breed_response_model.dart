import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiDogBreedResponseModel {
  final Map<String, List<String>> message;
  final String status;

  ApiDogBreedResponseModel({required this.message, required this.status});

  Map<String, dynamic> toMap() {
    return {
      // Convert each List<String> back to dynamic for JSON encoding
      'message': message.map((key, value) => MapEntry(key, value)),
      'status': status,
    };
  }

  factory ApiDogBreedResponseModel.fromMap(Map<String, dynamic> map) {
    // Ensure correct typing from dynamic to Map<String, List<String>>
    final messageFromMap = map['message'].map((key, value) => 
      MapEntry(key, List<String>.from(value))
    );

    return ApiDogBreedResponseModel(
      message: Map<String, List<String>>.from(messageFromMap),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiDogBreedResponseModel.fromJson(String source) => 
    ApiDogBreedResponseModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApiDogBreedResponseModel &&
      mapEquals(other.message, message) &&
      other.status == status;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode;
}
