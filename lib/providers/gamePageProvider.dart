import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List? question;
  int currentQuestion = 0;

  BuildContext context;

  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromApi();
  }

  Future<void> _getQuestionFromApi() async {
    try {
      var _response = await _dio.get(
        '',
        queryParameters: {
          'amount': 10,
          'difficulty': 'easy',
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
    if (question != null && question!.isNotEmpty) {
      return question![currentQuestion]?["question"];
    } else {
      return 'No questions available';
    }
  }
}
