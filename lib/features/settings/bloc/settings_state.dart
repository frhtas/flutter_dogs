part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {
  final String? version;

  const SettingsState({this.version});
}

final class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

final class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required String version}) : super(version: version);
}
