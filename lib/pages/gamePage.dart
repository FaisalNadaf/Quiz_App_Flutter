import 'package:flutter/material.dart';

class Gamepage extends StatelessWidget {
  late double _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return gameUI();
  }

  Widget gameUI() {
    return Scaffold(
      body: gameBody(),
    );
  }

  Widget gameBody() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _width * 0.1,
        vertical: _height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          question(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              trueBtn(),
              falseBtn(),
            ],
          )
        ],
      ),
    );
  }

  Widget question() {
    return const Text(
      'a apple a day keep doctor away',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget trueBtn() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _height * 0.01,
      ),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.green,
        child: const Text(
          "True",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  Widget falseBtn() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _height * 0.01,
      ),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.red,
        child: const Text(
          "False",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
