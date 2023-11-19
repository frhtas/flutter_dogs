part of 'dogs_bloc.dart';

@immutable
sealed class DogsEvent {}

class DogsInitialFetchEvent extends DogsEvent {}

class DogsImagesFetchEvent extends DogsEvent {
  final Map<String, dynamic> dogBreeds;

  DogsImagesFetchEvent({required this.dogBreeds});
}

class DogsImagesCachingEvent extends DogsEvent {
  final List<DogModel> dogs;

  DogsImagesCachingEvent({required this.dogs});
}

class DogsRandomImageEvent extends DogsEvent {
  final String breed;

  DogsRandomImageEvent({required this.breed});
}

class DogsBreedFilterEvent extends DogsEvent {
  final String filter;

  DogsBreedFilterEvent({required this.filter});
}

class DogsIsFabVisibleEvent extends DogsEvent {
  final bool isFabVisible;

  DogsIsFabVisibleEvent({required this.isFabVisible});
}
