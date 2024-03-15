import 'package:bloc/bloc.dart';
import 'package:dog_appnation/service/dog_api_service.dart';

sealed class DogBreedBlocEvent {}

final class AppInitializing extends DogBreedBlocEvent {}

class DogBreedBloc extends Bloc<DogBreedBlocEvent, Map<String, List<String>>?> {
  DogBreedBloc() : super(null) {
    on<AppInitializing>((event, emit) async {
      try {
        final breedsMap = await DogApiService().fetchDogBreeds();
        emit(breedsMap);
      } catch (e) {
        emit(null);
      }
    });
  }
}
