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
        child: Container(
          padding: EdgeInsets.fromLTRB(
            24,
            20,
            24,
            28 + MediaQuery.of(context).padding.bottom,
          ),
          color: Color.fromRGBO(232, 224, 210, 0.88),
          child: child,
        ),
      ),
    );
  }
}
