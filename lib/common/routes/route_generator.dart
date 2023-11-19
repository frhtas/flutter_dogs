import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/common/method_channel_handler.dart';
import 'package:flutter_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:flutter_dogs/features/dogs/ui/splash_screen.dart';
import 'package:flutter_dogs/features/landing/ui/landing_screen.dart';
import 'package:flutter_dogs/features/settings/ui/settings_screen.dart';

import '../../features/landing/bloc/landing_bloc.dart';
import '../../features/settings/bloc/settings_bloc.dart';

class RouteGenerator {
  final DogsBloc dogsBloc = DogsBloc();
  final LandingBloc landingScreenBloc = LandingBloc();
  final SettingsBloc settingsBloc = SettingsBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        dogsBloc.add(DogsInitialFetchEvent());
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DogsBloc>.value(
            value: dogsBloc,
            child: const SplashScreen(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LandingBloc>.value(
            value: landingScreenBloc,
            child: LandingScreen(dogsBloc: dogsBloc),
          ),
        );
      case '/settings':
        MethodChannelHandler(settingsBloc: settingsBloc);

        return ModalBottomSheetRoute(
          isScrollControlled: true,
          showDragHandle: true,
          enableDrag: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          ),
          builder: (_) => BlocProvider<SettingsBloc>.value(
            value: settingsBloc,
            child: const SettingsScreen(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
