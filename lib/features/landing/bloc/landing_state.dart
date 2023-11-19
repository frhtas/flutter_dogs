part of 'landing_bloc.dart';

@immutable
sealed class LandingState {
  final int tabIndex;

  const LandingState({required this.tabIndex});
}

final class LandingInitial extends LandingState {
  const LandingInitial({required int tabIndex}) : super(tabIndex: tabIndex);
}
