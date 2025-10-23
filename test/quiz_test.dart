import 'package:test/test.dart';
import 'package:week3_practice/domain/quiz.dart';

void main() {
  group('Quiz score calculation', () {
    test('should return 100% when all answers are correct', () {
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);

      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "4"));

      expect(quiz.getScoreInPercentage(), equals(100));
    });

    test('should return 50% when one answer is correct', () {
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);

      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "5"));

      expect(quiz.getScoreInPercentage(), equals(50));
    });

    test('should return 0% when all answers are wrong', () {
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);

      quiz.addAnswer(Answer(question: questions[0], answerChoice: "London"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "5"));

      expect(quiz.getScoreInPercentage(), equals(0));
    });
    test('should total points 6 if all answer correct', () {
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);

      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "4"));

      expect(quiz.getPoints(), equals(6)); // 2 questions * 3 points each
    });
    test('should get 3 point if 1 question wrong',(){
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "Paris"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "5"));
      expect(quiz.getPoints(), equals(3));
    });
    test('should get 0 point if all question wrong',(){
      final questions = [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
        ),
      ];
      final quiz = Quiz(questions: questions);
      quiz.addAnswer(Answer(question: questions[0], answerChoice: "London"));
      quiz.addAnswer(Answer(question: questions[1], answerChoice: "5"));
      expect(quiz.getPoints(), equals(0));
    });
  });
}
