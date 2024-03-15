import 'dart:convert';

class ApiImgResponseModel {
  final String message;
  final String status;

  ApiImgResponseModel({required this.message, required this.status});


  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory ApiImgResponseModel.fromMap(Map<String, dynamic> map) {
    return ApiImgResponseModel(
      message: map['message'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiImgResponseModel.fromJson(String source) => ApiImgResponseModel.fromMap(json.decode(source));
}
