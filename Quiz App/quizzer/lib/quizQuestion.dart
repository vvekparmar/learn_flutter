import 'question.dart';

class QuizQuestion
{
  int _questionNumber = 0;
  List<Question> _questionBank = [
    Question(que:'Creator of C is Dennis Ritchie.',ans:true),
    Question(que:'Creator of Python is Guido van Rosumn.',ans:true),
    Question(que:'Php is used in python.',ans:false),
    Question(que:'We create Mobile Application using Python.',ans:true),
    Question(que:'We Access LAN Remotely.',ans:false),
    Question(que:'We give Parameterized Constructor without Default Constructor in C++.',ans:true),
    Question(que:'Javascript is for Backend.',ans:false),
    Question(que:'We create class in C.',ans:false),
  ];

  void nextQuestion()
  {
    if(_questionNumber < _questionBank.length)
    {
      _questionNumber++;
    }
  }

  String getQuestion()
  {
    return _questionBank[_questionNumber].question;
  }

  bool getAnswer()
  {
    return _questionBank[_questionNumber].answer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length-1) {
      return true;
    }
    else {
      return false;
    }
  }

}