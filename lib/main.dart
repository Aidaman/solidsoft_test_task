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
      title: 'Solid Software Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color? backgroundColor;

  Color? computeTextColor() {
    if (backgroundColor == null) return null;

    if (backgroundColor!.computeLuminance() < 0.25) {
      return Colors.white;
    }

    return Colors.black;
  }

  void randomiseBackgroundColor() {
    setState(() {
      backgroundColor = Color(
        (Random().nextDouble() * 0xFFFFFF).toInt(),
      ).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: randomiseBackgroundColor,
      child: Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.lighten,
              gradient: const LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.white10,
                  Colors.white12,
                  Colors.white24,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 2,
                  color: Colors.black12,
                  offset: Offset(4, 8),
                )
              ],
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Hello There',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: computeTextColor(),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
