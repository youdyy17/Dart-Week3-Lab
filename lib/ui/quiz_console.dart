import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  final Quiz quiz;
  Player? player;

  QuizConsole({required this.quiz});

  // enter name before start quiz
  bool enterPlayerName() {
    stdout.write('Enter your name: ');
    String? name = stdin.readLineSync();
    if (name != null && name.trim().isNotEmpty) {
      player = Player(name: name.trim() , quiz: quiz);
      print('Your Name: ${player!.name}!\n');
      return true;
    } else {
      print('please enter your name before starting the quiz.\n');
      return false;
    }
  }

  void startQuiz() {
    while (true) {
      if (!enterPlayerName()) return;

      print('--- Welcome to the Quiz ---\n');

      for (var question in quiz.questions) {
        // print question and points on the same line
        print('Question: ${question.title} - (${question.points} points)');
        // prettier choice display
        print('Choices: ${question.choices.join(', ')}');

        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.trim().isNotEmpty) {
          final answer =
              Answer(question: question, answerChoice: userInput.trim());
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int score = quiz.getScoreInPercentage();
      print('--- Quiz Finished ---');
      print('${player?.name}, Your score: $score % correct');

      int totalPoints = quiz.getPoints();
      print('${player?.name}, Score in points: $totalPoints');
      print('Your Name: ${player?.name}          Score: ${player?.getPoints}');

      quiz.clearAnswers();
      player = null;
      print('\n');
    }

  
  }
}

