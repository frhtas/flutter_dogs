part of 'dogs_bloc.dart';

@immutable
sealed class DogsState {}

final class DogsInitial extends DogsState {}

final class DogsFetchingSuccessful extends DogsState {
  final Map<String, dynamic> dogBreeds;

  DogsFetchingSuccessful({required this.dogBreeds});
}

final class DogsImagesFetchingSuccessful extends DogsState {
  final List<DogModel> dogs;

  DogsImagesFetchingSuccessful({required this.dogs});
}

final class DogsImagesCachingSuccessful extends DogsState {
  final List<DogModel> dogs;

  DogsImagesCachingSuccessful({required this.dogs});
}

final class DogsRandomImageSuccessful extends DogsState {
  final String imageUrl;

  DogsRandomImageSuccessful({required this.imageUrl});
}

final class DogsBreedFilterSuccessful extends DogsState {
  final String filter;
  final List<DogModel> filteredDogs;

  DogsBreedFilterSuccessful({required this.filteredDogs, required this.filter});
}

final class DogsIsFabVisible extends DogsState {
  final bool isFabVisible;

  DogsIsFabVisible({required this.isFabVisible});
}
