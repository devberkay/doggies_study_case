import 'package:bloc/bloc.dart';
import 'package:dog_appnation/service/dog_api_service.dart';

sealed class DogImageBlocEvent {}

final class GenerateButtonPressed extends DogImageBlocEvent {}

class DogImageBloc extends Bloc<DogImageBlocEvent, String?> {
  DogImageBloc({required String breed}) : super(null) {
    on<GenerateButtonPressed>((event, emit) async {
      final imgUrl = await DogApiService().fetchDogImage(breed);
      emit(imgUrl);
    });
  }
}
