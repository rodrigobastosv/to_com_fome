import 'package:flutter/material.dart';

final questions = [
  Question(
    question: 'Duvida 1',
    answer: 'Resposta 1',
  ),
  Question(
    question: 'Duvida 2',
    answer: 'Resposta 2',
  ),
  Question(
    question: 'Duvida 3',
    answer: 'Resposta 3',
  ),
  Question(
    question: 'Duvida 4',
    answer: 'Resposta 4',
  ),
  Question(
    question: 'Duvida 5',
    answer: 'Resposta 5',
  ),
  Question(
    question: 'Duvida 6',
    answer: 'Resposta 6',
  ),
  Question(
    question: 'Duvida 7',
    answer: 'Resposta 7',
  ),
  Question(
    question: 'Duvida 8',
    answer: 'Resposta 8',
  ),
  Question(
    question: 'Duvida 9',
    answer: 'Resposta 9',
  ),
  Question(
    question: 'Duvida 10',
    answer: 'Resposta 10',
  ),
];

class Question {
  Question({this.question, this.answer});

  final String question;
  final String answer;
}

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) => ListTile(
        leading: Text(
          '${i + 1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        title: Text(questions[i].question),
        subtitle: Text(questions[i].answer),
      ),
      itemCount: questions.length,
    );
  }
}
