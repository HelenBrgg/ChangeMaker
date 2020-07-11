import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final Color _color;

  TextSection(this._color);
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color,
      ),
      child: Text('Hi'),
    );
  }
}