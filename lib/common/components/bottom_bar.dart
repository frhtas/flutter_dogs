import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> bottomBarItems;

  const BottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.bottomBarItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const BottomBarClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        color: bottomBarBackground,
        padding: const EdgeInsets.only(top: 8.0),
        child: Stack(
          children: [
            BottomNavigationBar(
              items: bottomBarItems,
              currentIndex: selectedIndex,
              onTap: onTap,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 24,
                width: 2,
                margin: const EdgeInsets.only(top: 16.0),
                decoration: const BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color color;

  const BottomBarItem({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(iconPath, height: 32, width: 32, color: color),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class BottomBarClipper extends CustomClipper<Path> {
  const BottomBarClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(40.0, 0.0);
    path.quadraticBezierTo(16.0, 0.0, 12.0, 16.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 12.0, 16.0);
    path.quadraticBezierTo(size.width - 16.0, 0.0, size.width - 40.0, 0.0);
    path.lineTo(size.width - 40, 0.0);
    return path;
  }

  @override
  bool shouldReclip(BottomBarClipper oldClipper) => false;
}

class BottomBarBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;

  const BottomBarBorderPainter({
    this.strokeWidth = 2.0,
    this.color = grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(40.0, 0.0);
    path.quadraticBezierTo(16.0, 0.0, 12.0, 16.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 12.0, 16.0);
    path.quadraticBezierTo(size.width - 16.0, 0.0, size.width - 40.0, 0.0);
    path.lineTo(size.width - 40, 0.0);
    path.lineTo(40.0, 0.0);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomBarBorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BottomBarBorderPainter oldDelegate) => false;
}
