import 'package:flutter/material.dart';
import 'package:study/utils/color.dart';

class PersonAvatar extends StatelessWidget {
  final String username;
  final double radius;
  const PersonAvatar({
    Key? key,
    required this.username,
    this.radius = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = generateRandomGradient(username);
    Color iconColor = getBlackOrWhite(gradient.colors.last);
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
      width: radius * 2,
      height: radius * 2,
      child: Icon(Icons.person, color: iconColor, size: radius * 1.2),
    );
  }
}
