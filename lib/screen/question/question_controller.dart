import 'dart:math';

import 'package:get/get.dart';
import 'package:takrorlash/data/local/local_data.dart';

class QuestionController extends GetxController{
  var errorEmoji = '😳'.obs;
  RxBool isFinish = false.obs;
  RxBool isStart = true.obs;
  int index = -1.obs;
  var letters = [].obs;
  RxString question = "".obs;
  RxString answer = "".obs;
  getQuestion()async{
    isStart.value = false;
    if(index < questionsList.length){
    index++;
    question.value = questionsList[index].question;
    answer.value = questionsList[index].correctAnswer;
    if(isStart.value == false){
      letters.clear();
    }
    await formingLetters();
    }else{
      isFinish.value = true;
      index = 0;
      getQuestion();
    }
  }
  Future<void> formingLetters() async {
    for (int i = 0; i <= 12; i++) {
      if (i < questionsList[index].correctAnswer.length) {
        letters.add(questionsList[index].correctAnswer[i].toUpperCase());
      } else {
        letters.add(getRandomLetter());
      }
    }
    letters.shuffle();
    letters.add('<=');
  }



  String getRandomLetter() {
    List<String> randomLetters = [
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
      'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    ];
    var errorEmojiList = [
      "😳",
      "😱",
      "🤯",
      "🥶",
      "🤬"
      "🤲🧠"
    ];
    Random random = Random();
    int randomIndex = random.nextInt(randomLetters.length);
    int randomEmoji = random.nextInt(errorEmojiList.length);
    errorEmoji.value = errorEmojiList[randomEmoji];
    return randomLetters[randomIndex];
  }


}