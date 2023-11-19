import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsLoading()) {
    on<SettingsEvent>((event, emit) {
      if (event is LoadSettings) {
        emit(SettingsLoaded(version: event.version));
      }
    });
  }
}
