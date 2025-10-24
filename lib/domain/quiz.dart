class Question{
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points =3;

  Question({required this.title, required this.choices, required this.goodChoice});
  //getter
  int get getPoints => points;
}

class Answer{
  final Question question;
  final String answerChoice;
  

  Answer({required this.question, required this.answerChoice});

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

// new: Submission to record a player's attempt
class Submission {
  String playerName;
  List<Answer> answers;
  int? score;

  Submission({
    required this.playerName,
    required this.answers,
    this.score,
  });

  void saveScore(String playerName, int score) {
    this.playerName = playerName;
    this.score = score;
  }
}

class Player{
  final String name;
  Player({required this.name});
  // Example helper: take a quiz by providing answers (does not mutate quiz state)
  int takeQuizPoints(Quiz quiz, List<Answer> answers) {
    final result = quiz.evaluateAnswers(answers);
    return result['points']!;
  }
}

class Quiz{
  final List<Question> questions;
  final List <Answer> answers = [];
  final Map<String, int> playerScores = {};
  final List<Submission> submissions = [];

  Quiz({required List<Question> questions}):
  questions = List.unmodifiable(questions);

  void addAnswer(Answer answer) {
     this.answers.add(answer);
  }
  //get point
  int getPoints() {
    int totalPoints =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalPoints += answer.question.points;
      }
    }
    return totalPoints;
  }

  int getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore/ questions.length)*100).toInt();
  }
  void clearAnswers(){
    answers.clear();
  }
  // Evaluate answers without mutating internal state
  Map<String, int> evaluateAnswers(List<Answer> answersToEvaluate) {
    int totalPoints = 0;
    int totalCorrect = 0;
    for (final answer in answersToEvaluate) {
      if (answer.isGood()) {
        totalPoints += answer.question.points;
        totalCorrect++;
      }
    }
    final percent = questions.isEmpty ? 0 : ((totalCorrect / questions.length) * 100).toInt();
    return {'points': totalPoints, 'percent': percent};
  }

  // Convenience: submit a player's answers and save points to playerScores
  Submission submitAnswersFor(String playerName, List<Answer> answersToEvaluate) {
    final result = evaluateAnswers(answersToEvaluate);
    final submission = Submission(
      playerName: playerName,
      answers: List.unmodifiable(answersToEvaluate),
      points: result['points']!,
      percent: result['percent']!,
    );
    playerScores[playerName] = submission.points;
    submissions.add(submission);
    return submission;
  }
}