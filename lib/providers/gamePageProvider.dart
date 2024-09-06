import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app_flutter/pages/homePage.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List? question;
  int currentQuestion = 0;
  num maxQuestion = 10;
  BuildContext context;
  String level;
  int correct = 0;
  int wrong = 0;

  GamePageProvider({required this.context, required this.level}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromApi();
  }

  Future<void> _getQuestionFromApi() async {
    try {
      var _response = await _dio.get(
        '',
        queryParameters: {
          'amount': maxQuestion,
          'difficulty': level,
          'type': 'boolean',
        },
      );

      if (_response.statusCode == 200) {
        var _data = jsonDecode(
          _response.toString(),
        );
        question = _data["results"];
        notifyListeners();
      } else {
        // Handle API errors
        print('Error: ${_response.statusCode} - ${_response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print('Dio error: ${e.message}');
    } catch (e) {
      // Handle other errors
      print('Unexpected error: $e');
    }
  }

  String getQuestionText() {
    String qsn = 'empty';
    if (question != null && question!.isNotEmpty) {
      try {
        qsn = question![currentQuestion]?["question"];
      } catch (e) {
        print('error in game page provider');
      }

      return qsn;
    } else {
      return 'No questions available';
    }
  }

  void answerQuestion(String ans) async {
    bool isCorrect = question?[currentQuestion]['correct_answer'] == ans;
    currentQuestion++;
    isCorrect ? correct++ : wrong++;
    print(isCorrect ? "correct" : "wrong");
    print(level);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_box_rounded : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    Navigator.pop(context);
    if (currentQuestion == maxQuestion) {
      scoreMsg();
    } else {
      notifyListeners();
    }
  }

  Future<void> scoreMsg() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              correct >= maxQuestion / 2 ? Colors.green[300] : Colors.red,
          title: Text('Game Over'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Correct : $correct'),
              Text('Wrong : $wrong'),
            ],
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext _context) {
          return HomePage();
        },
      ),
    );
    notifyListeners();
  }
}
