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

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApiImgResponseModel &&
      other.message == message &&
      other.status == status;
  }

  @override
  int get hashCode => Object.hash(
        message,
        status
      );
}
