import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:flutter_dogs/features/dogs/ui/home_screen.dart';

import '../../../common/app_colors.dart';
import '../../../common/assets.dart';
import '../../../common/components/bottom_bar.dart';
import '../bloc/landing_bloc.dart';

List<BottomNavigationBarItem> bottomBarItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Image.asset(Assets.houseLine, color: Colors.black),
    activeIcon: Image.asset(Assets.houseLine, color: primaryColor),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Image.asset(Assets.wrench, color: Colors.black),
    activeIcon: Image.asset(Assets.wrench, color: primaryColor),
    label: 'Settings',
  ),
];

class LandingScreen extends StatefulWidget {
  final DogsBloc dogsBloc;

  const LandingScreen({
    Key? key,
    required this.dogsBloc,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late List<Widget> bottomBarScreens;
  late HomeScreen homeScreen;

  @override
  void initState() {
    homeScreen = HomeScreen(dogsBloc: widget.dogsBloc);
    bottomBarScreens = <Widget>[
      homeScreen,
      const SizedBox(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingBloc, LandingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: CustomPaint(
            painter: const BottomBarBorderPainter(),
            child: BottomBar(
              bottomBarItems: bottomBarItems,
              selectedIndex: state.tabIndex,
              onTap: (index) {
                context.read<LandingBloc>().add(TabChange(tabIndex: index));

                if (index == 1) {
                  Navigator.pushNamed(context, '/settings').then((value) {
                    context.read<LandingBloc>().add(TabChange(tabIndex: 0));
                  });
                } else {
                  homeScreen = HomeScreen(dogsBloc: widget.dogsBloc);
                }
              },
            ),
          ),
          body: IndexedStack(
            index: state.tabIndex,
            children: bottomBarScreens,
          ),
        );
      },
    );
  }
}
