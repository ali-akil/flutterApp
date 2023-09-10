import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final bool ismale;
  final int age;
  final int result;
  const BMIResultScreen(
      {super.key, required this.result, required this.age, required this.ismale});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BMI_RESULT"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              ismale ? "MALE" : "FEMALE",
              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Result :$result",
              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Age : $age",
              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            )
          ]),
        ));
  }
}
