import 'package:background_animated/background_animated.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Animated',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ParallaxRain(
              dropColors: [...Colors.primaries, ...Colors.accents],
            ),
          ),
          Expanded(
            child: Starfield(
              colors: [...Colors.primaries, ...Colors.accents],
            ),
          ),
          Expanded(
            child: Fireworks(
              shapeColors: [...Colors.primaries, ...Colors.accents],
              particleColors: [...Colors.primaries, ...Colors.accents],
            ),
          ),
        ],
      ),
    );
  }
}
