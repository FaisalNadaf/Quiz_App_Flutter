import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/providers/gamePageProvider.dart';
import 'package:provider/provider.dart';

class Gamepage extends StatelessWidget {
  late double _height, _width;

  GamePageProvider? _gamePageProvider;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context),
      child: gameUI(),
    );
  }

  Widget gameUI() {
    return Builder(
      builder: (context) {
        _gamePageProvider = context.watch<GamePageProvider>();
        if (_gamePageProvider!.question != null) {
          return Scaffold(
            body: gameBody(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget gameBody() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _width * 0.1,
        vertical: _height * 0.18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          question(),
          Column(
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
    return Text(
      _gamePageProvider!.getQuestionText(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget trueBtn() {
    return Container(
      width: _width * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: _height * 0.01,
      ),
      child: MaterialButton(
        onPressed: () {
          _gamePageProvider?.answerQuestion("True");
        },
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
      width: _width * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: _height * 0.01,
      ),
      child: MaterialButton(
        onPressed: () {
          _gamePageProvider?.answerQuestion("False");
        },
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
