import 'package:flutter/material.dart';

class GuidedOverlay extends StatelessWidget {
  final Widget child;
  final bool showOverlay;

  const GuidedOverlay({super.key, required this.child, required this.showOverlay});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showOverlay)
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.srcOut),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: Text(
                '这是新手引导蒙版',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
      ],
    );
  }
}

