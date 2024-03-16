import 'package:bloc/bloc.dart';
import 'package:dog_appnation/model/api/api_dog_breed_response_model.dart';
import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/service/dog_api_service.dart';
import 'package:flutter/material.dart';

sealed class DogSearchBlocState {}

class DogSearchLoading extends DogSearchBlocState {}

class DogSearchData extends DogSearchBlocState {
  final String imgUrl;

  DogSearchData({required this.imgUrl});
}

class DogSearchError extends DogSearchBlocState {
  final Object error;
  final StackTrace stackTrace;

  DogSearchError({required this.error, required this.stackTrace});
}

sealed class DogSearchBlocEvent {}

final class onTextChanged extends DogSearchBlocEvent {
  final String newText;

  onTextChanged({required this.newText});
}

class DogSearchBloc extends Bloc<DogSearchBlocEvent, String?> {
  DogSearchBloc() : super(null) {
    on<onTextChanged>((event, emit) async {
      emit(event.newText);
    });
  }
}
