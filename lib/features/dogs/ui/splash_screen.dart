import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/common/assets.dart';

import '../bloc/dogs_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DogsBloc, DogsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DogsFetchingSuccessful) {
          context
              .read<DogsBloc>()
              .add(DogsImagesFetchEvent(dogBreeds: state.dogBreeds));
        } else if (state is DogsImagesFetchingSuccessful) {
          context
              .read<DogsBloc>()
              .add(DogsImagesCachingEvent(dogs: state.dogs));
        } else if (state is DogsImagesCachingSuccessful) {
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
        return Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(Assets.splashLogo),
          ),
        );
      },
    );
  }
}
