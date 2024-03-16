import 'dart:ui';

import 'package:dog_appnation/model/api/dog_breed_model.dart';
import 'package:dog_appnation/pages/home/dog_container.dart';
import 'package:dog_appnation/service/dog_breed_bloc.dart';
import 'package:dog_appnation/service/dog_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            return BlocConsumer<DogSearchBloc, String?>(
                listener: (context, state) {
              if (state != null && state.isNotEmpty && context.mounted) {
                _scrollController.jumpTo(0);
              }
            }, builder: (context, blocState) {
              final filteredBreeds = state.breeds
                  .where((element) => element.breed
                      .toLowerCase()
                      .contains(blocState?.toLowerCase() ?? ""))
                  .toList();
              return filteredBreeds.isEmpty
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100),
                          Text("No results found",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          SizedBox(height: 8),
                          Text(
                            "Try searching with another word",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF3C3C43).withOpacity(0.6)),
                          ),
                        ],
                      ),
                    )
                  : GridView.count(
                      controller: _scrollController,
                      shrinkWrap: true,
                      // cacheExtent: 1000 // imglar icin local cache yapildi ama in-memory cache ile ekstra olarak desteklenebilir burada.
                      padding: const EdgeInsets.only(
                          bottom: 32 +
                              kBottomNavigationBarHeight * 1.75 +
                              kBottomNavigationBarHeight * 1.15,
                          left: 16,
                          right: 16,
                          top: 16),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: List.generate(
                          filteredBreeds.length,
                          (index) => DogContainer(
                              dogBreedModel: filteredBreeds[index])),
                    );
            });
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
