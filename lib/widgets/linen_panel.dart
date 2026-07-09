import 'dart:ui';

import 'package:flutter/material.dart';

class LinenPanel extends StatelessWidget {
  final Widget child;
  const LinenPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: const Color.fromRGBO(232, 224, 210, 0.88),
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0.04,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/textures/noise.png'),
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                20,
                24,
                28 + MediaQuery.of(context).padding.bottom,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
