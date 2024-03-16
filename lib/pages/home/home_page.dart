import 'dart:ui';

import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/pages/home/dog_container.dart';
import 'package:dog_appnation/service/dog_breed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dogBreedBloc = DogBreedBloc();

    return Container(
      color: Colors.white,
      child: BlocBuilder<DogBreedBloc, DogBreedBlocState>(
          builder: (context, state) {
        if (state is DogBreedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DogBreedData) {
          if (state.breeds.isNotEmpty) {
            return GridView.count(
              shrinkWrap: true,
              cacheExtent: double.infinity,
              padding: const EdgeInsets.only(
                  bottom: 16 +
                      kBottomNavigationBarHeight * 1.75 +
                      kBottomNavigationBarHeight * 1.15,
                  left: 16,
                  right: 16,
                  top: 16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: List.generate(state.breeds.length,
                  (index) => DogContainer(dogBreedModel: state.breeds[index])),
            );
          } else {
            return const Center(
              child: Text("No dog breeds found"),
            );
          }
        } else if (state is DogBreedError) {
          debugPrint("DogBreedError: ${state.error}\n\n ${state.stackTrace}");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error fetching dog breeds"),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    context.read<DogBreedBloc>().add(AppInitializing());
                  },
                  child: const Text("Try again"),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error fetching dog breeds"),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    context.read<DogBreedBloc>().add(AppInitializing());
                  },
                  child: const Text("Try again"),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
