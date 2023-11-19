part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class LoadSettings extends SettingsEvent {
  final String version;

  LoadSettings({required this.version});
}
