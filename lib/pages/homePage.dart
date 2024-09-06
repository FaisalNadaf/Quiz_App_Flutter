import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/pages/gamePage.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }
}

class _homePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  late double _height, _width;
  double sliderCount = 0;
  late String difficulty;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appName(),
            slider(),
            startBtn(),
          ],
        ),
      ),
    );
  }

  Widget appName() {
    if (sliderCount == 0) {
      difficulty = 'easy';
    } else if (sliderCount == 1) {
      difficulty = 'medium';
    } else if (sliderCount == 2) {
      difficulty = 'hard';
    } else {
      difficulty = ''; // Handle edge cases if necessary
    }
    return Column(
      children: [
        const Text(
          'Quiz App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        Text(
          difficulty,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget slider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Slider(
        label: difficulty,
        value: sliderCount,
        min: 0,
        max: 2,
        divisions: 2, // Optional: add divisions for better control
        onChanged: (value) {
          setState(() {
            sliderCount = value;
          });
        },
      ),
    );
  }

  Widget startBtn() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        vertical: _height * 0.02,
        horizontal: _width * 0.2,
      ),
      color: Colors.blue[300],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext _context) {
              return Gamepage(level: difficulty);
            },
          ),
        );
      },
      child: const Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
