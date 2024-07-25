import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:takrorlash/screen/question/question_controller.dart';
import 'package:takrorlash/utils/style/app_text_style.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final controller = Get.put(QuestionController()..getQuestion());
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('--------------------build run');
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main.jpg',
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: -200,
            child:
          Lottie.asset('assets/lottie/cloud.json'),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        debugPrint('--------------------obx text run');

                        return Text(
                        controller.question.value,
                        style: AppTextStyle.medium.copyWith(fontSize: 24),
                      );},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Pinput(
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border.all(color:  Colors.green),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        errorPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border.all(color:  Colors.red),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        length: controller.answer.value.length,
                        controller: textEditingController,
                        validator: (value) {
                          if (value == controller.answer.value.toUpperCase()) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Lottie.asset('assets/lottie/winner.json'),
                                        Text(
                                          "You Win!",
                                          style: AppTextStyle.medium
                                              .copyWith(fontSize: 22),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          textEditingController.clear();
                                          controller.getQuestion();
                                          Navigator.pop(context);
                                        },
                                        child: Obx(()=> Text(
                                            controller.isFinish.value?"Finish":'Next'),)
                                      )
                                    ],
                                  );
                                });
                            return null;
                          } else {
                            debugPrint("else______________$value");
                            return controller.errorEmoji.value;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Wrap(
                        spacing: 2,
                        runSpacing: 5,
                        children: [
                          ...List.generate(controller.letters.length, (index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.green,
                              ),
                              child: Ink(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    if (controller.letters[index] != "<=" &&
                                        textEditingController.text.length <=
                                            controller.answer.value.length) {
                                      textEditingController.text +=
                                          controller.letters[index];
                                    } else {
                                      String text = textEditingController.text;
                                      if (text.isNotEmpty) {
                                        text = text.substring(0, text.length - 1);
                                      }
                                      textEditingController.text = text;
                                    }
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        controller.letters[index],
                                        style: AppTextStyle.medium
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
