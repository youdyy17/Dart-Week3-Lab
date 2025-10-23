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

class Player{
  String name;
  Quiz quiz;
  Player({required this.name, required this.quiz});

  int get getScore => quiz.getScoreInPercentage();
  int get getPoints => quiz.getPoints();
}

class Quiz{
  List<Question> questions;
  List <Answer> answers =[];
  final Map<String, int> playerScores = {};


  Quiz({required this.questions});

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
}