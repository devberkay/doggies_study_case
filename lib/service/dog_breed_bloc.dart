import 'package:bloc/bloc.dart';
import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/service/dog_api_service.dart';
import 'package:collection/collection.dart';
import 'package:dog_appnation/service/image_utils.dart';
import 'package:dog_appnation/service/string_utils.dart';

// statuses:

sealed class DogBreedBlocState {}

class DogBreedLoading extends DogBreedBlocState {}

class DogBreedData extends DogBreedBlocState {
  final List<DogBreedModel> breeds;

  DogBreedData({required this.breeds});
}

class DogBreedError extends DogBreedBlocState {
  final Object error;
  final StackTrace stackTrace;

  DogBreedError({required this.error, required this.stackTrace});
}


// events:

sealed class DogBreedBlocEvent {}

final class AppInitializing extends DogBreedBlocEvent {}

class DogBreedBloc extends Bloc<DogBreedBlocEvent, DogBreedBlocState> {
  DogBreedBloc() : super(DogBreedData(breeds: [])) {
    on<AppInitializing>((event, emit) async {
      try {
        emit(DogBreedLoading());
        final breedsMap = await DogApiService().fetchDogBreeds();
        final imageUrls = await Future.wait(breedsMap.keys.map((e) async {
          final url = await DogApiService().fetchDogImage(e);
          return url;
        }));
        await Future.wait(imageUrls.map((e) => ImageUtils.cacheImageFromNetwork(e)));
        final breedModels = breedsMap.entries
            .mapIndexed((index, e) => DogBreedModel(
                  breed: StringUtils.capitalize(e.key),
                  subBreeds: (e.value).map((e) => StringUtils.capitalize(e)).toList(),
                  imageUrl: imageUrls[index],
                ))
            .toList();
        emit(DogBreedData(breeds: breedModels));
      } catch (error, stackTrace) {
        emit(DogBreedError(error: error, stackTrace: stackTrace));
      }
    });
  }
}
