import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void playSound() {
  final player = AudioPlayer();
  player.play(AssetSource('aqua1.wav'));
}

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(
        50.0,
      ),
      duration: const Duration(
        milliseconds: 1000,
      ),
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 26.0,
              ),
        ),
      ),
    ),
  );
}
