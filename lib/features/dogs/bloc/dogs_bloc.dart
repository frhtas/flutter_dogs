import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_dogs/common/caching_handler.dart';
import 'package:flutter_dogs/features/dogs/models/dog_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'dogs_event.dart';
part 'dogs_state.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  var client = http.Client();
  final CachingHandler cachingHandler = CachingHandler();
  Map<String, dynamic> dogBreeds = {};
  List<DogModel> dogs = [];
  List<DogModel> filteredDogs = [];

  DogsBloc() : super(DogsInitial()) {
    on<DogsInitialFetchEvent>(dogsInitialFetchEvent);
    on<DogsImagesFetchEvent>(dogsImagesFetchEvent);
    on<DogsImagesCachingEvent>(dogsImagesCachingEvent);
    on<DogsRandomImageEvent>(dogsRandomImageEvent);
    on<DogsBreedFilterEvent>(dogsBreedFilterEvent);
    on<DogsIsFabVisibleEvent>(dogsIsFabVisibleEvent);
  }

  FutureOr<void> dogsInitialFetchEvent(
      DogsInitialFetchEvent event, Emitter<DogsState> emit) async {
    try {
      var response =
          await client.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dogBreeds = decodedResponse['message'];

      emit(DogsFetchingSuccessful(dogBreeds: dogBreeds));
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> dogsImagesFetchEvent(
      DogsImagesFetchEvent event, Emitter<DogsState> emit) async {
    try {
      final Map<String, dynamic> dogBreeds = event.dogBreeds;

      for (String dogBreed in dogBreeds.keys) {
        var response = await client.get(
            Uri.parse('https://dog.ceo/api/breed/$dogBreed/images/random'));

        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        var imageUrl = decodedResponse['message'];
        var imageResponse = await client.get(Uri.parse(imageUrl));

        if (imageResponse.statusCode != 200) {
          continue;
        } else {
          if (dogBreeds[dogBreed] == null) {
            dogs.add(DogModel(
              breed: dogBreed,
              image: imageUrl,
              subBreeds: [],
            ));
          } else {
            List<String> subBreeds = dogBreeds[dogBreed].cast<String>();
            dogs.add(DogModel(
              breed: dogBreed,
              image: imageUrl,
              subBreeds: subBreeds,
            ));
          }
        }
      }

      emit(DogsImagesFetchingSuccessful(dogs: dogs));
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> dogsImagesCachingEvent(
      DogsImagesCachingEvent event, Emitter<DogsState> emit) async {
    try {
      final List<DogModel> dogs = event.dogs;

      for (var dog in dogs) {
        await cachingHandler.cacheImage(dog.image);
      }

      emit(DogsImagesCachingSuccessful(dogs: dogs));
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> dogsRandomImageEvent(
      DogsRandomImageEvent event, Emitter<DogsState> emit) async {
    emit(DogsRandomImageSuccessful(imageUrl: ""));

    try {
      final String breed = event.breed;

      var response = await client
          .get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      var imageUrl = decodedResponse['message'];

      emit(DogsRandomImageSuccessful(imageUrl: imageUrl));
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> dogsBreedFilterEvent(
      DogsBreedFilterEvent event, Emitter<DogsState> emit) {
    filteredDogs = dogs
        .where((dog) =>
            dog.breed.toLowerCase().contains(event.filter.toLowerCase()))
        .toList();
    print(filteredDogs.length);
    emit(DogsBreedFilterSuccessful(
        filteredDogs: filteredDogs, filter: event.filter));
  }

  FutureOr<void> dogsIsFabVisibleEvent(
      DogsIsFabVisibleEvent event, Emitter<DogsState> emit) {
    emit(DogsIsFabVisible(isFabVisible: event.isFabVisible));
  }
}
