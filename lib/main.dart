import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animação',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Animação controlada'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animatioMatriz;
  late Animation<AlignmentGeometry> animatePosition;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    animatioMatriz = Tween(
      begin: 0.0,
      end: pi * 8,
    ).animate(
      animationController,
    );

    animatePosition = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topRight),
          weight: 2),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.bottomRight),
          weight: 2),
      TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
    ]).animate(animationController);

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Align(
            alignment: animatePosition.value,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animatioMatriz.value),
              alignment: FractionalOffset.center,
              child: Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Image.network(
                    'https://www.pngall.com/wp-content/uploads/4/Empty-Gold-Coin-Transparent.png'),
              ),
            ),
          );
        },
      ),
    );
  }
}
