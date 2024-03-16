import 'package:bloc/bloc.dart';
import 'package:dog_appnation/service/dog_api_service.dart';
import 'package:flutter/material.dart';

sealed class DogImageBlocState {}

class DogImageLoading extends DogImageBlocState {}

class DogImageData extends DogImageBlocState {
  final String imgUrl;

  DogImageData({required this.imgUrl});
}

class DogImageError extends DogImageBlocState {
  final Object error;
  final StackTrace stackTrace;

  DogImageError({required this.error, required this.stackTrace});
}

sealed class DogImageBlocEvent {}

final class GenerateButtonPressed extends DogImageBlocEvent {
  final String dogBreed;

  GenerateButtonPressed({required this.dogBreed});
}

class DogImageBloc extends Bloc<DogImageBlocEvent, DogImageBlocState?> {
  DogImageBloc() : super(null) {
    on<GenerateButtonPressed>((event, emit) async {
      try {
        emit(DogImageLoading());
        final imgUrl = await DogApiService().fetchDogImage(event.dogBreed.toLowerCase());
        debugPrint("imgUrl-generated: $imgUrl");
        emit(DogImageData(imgUrl: imgUrl));
      } catch (e, st) {
        debugPrint("DogImageError: $e\n\n $st");
        emit(DogImageError(error: e, stackTrace: st));
      }
    });
  }
}
