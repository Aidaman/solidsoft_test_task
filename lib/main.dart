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
    /*
      There were some methods to generate a random colour, such as:
    
        backgroundColor = Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          1,
        );

      this method is simple and intuitive, the most readable of three
      
      ---
      
      Also I could generate random string. I could do it by declaring:
        static const letters = '01234567890ABCDEF';

      and then making up a string like this:
        final randomString = List.generate(
          6,
          (index) => letters[Random().nextInt(letters.length)],
        ).join();
        Color color = Color(int.parse('0xFF$randomString'));

      but this method is complex, and, not to mention, it consumes a lot of memory
      
      ---

      short googling got me accustomed with the method I ended up using for this task:
      It uses a signle random and performs a simple convertion of a random double to hexadecimal
      making this method more memory-efficient and faster
     */
    setState(() {
      backgroundColor = Color(
        (Random().nextDouble() * 0xFFFFFF).toInt(),
      ).withOpacity(1.0);
    });
  }

  void resetBackgroundColor() {
    setState(() {
      backgroundColor = Theme.of(context).colorScheme.surface;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: randomiseBackgroundColor,
      child: Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: resetBackgroundColor,
                  color: computeTextColor(),
                  icon: const Icon(Icons.restart_alt),
                ),
              ),
              Center(
                child: Text(
                  'Hello There',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: computeTextColor(),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
