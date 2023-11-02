import 'package:fit_track/app/common/app_title.dart';
import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  static const _elevation = 5.0;
  static const _padding = 50.0;
  static final _color = Colors.black.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _elevation,
      color: _color,
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppTitle(),
            ...children,
          ],
        ),
      ),
    );
  }
}
