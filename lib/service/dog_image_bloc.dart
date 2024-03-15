import 'package:bloc/bloc.dart';
import 'package:dog_appnation/service/dog_api_service.dart';

sealed class DogImageBlocEvent {}

final class GenerateButtonPressed extends DogImageBlocEvent {
  final String breed;
  GenerateButtonPressed(this.breed);
}

final class BreedTypesFetched extends DogImageBlocEvent {
  final String breed;
  BreedTypesFetched(this.breed);
}

class DogImageBloc extends Bloc<DogImageBlocEvent, String?> {
  DogImageBloc() : super(null) {
    on<BreedTypesFetched>((event, emit) async {
      final imgUrl = await DogApiService().fetchDogImage(event.breed);
      emit(imgUrl);
    });
  }
}
