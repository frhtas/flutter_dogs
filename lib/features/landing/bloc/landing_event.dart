part of 'landing_bloc.dart';

@immutable
sealed class LandingEvent {}

class TabChange extends LandingEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
