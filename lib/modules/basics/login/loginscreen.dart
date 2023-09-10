import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/components/components.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool ispass = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "login",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormfiled(
                      controller: email,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          return " the Email must be not empty";
                        }
                      },
                      label: "email",
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormfiled(
                      controller: password,
                      type: TextInputType.visiblePassword,
                      label: "password",
                      validate: (value) {
                        if (value.isEmpty) {
                          return "the password must be not empty ";
                        }
                      },
                      prefix: Icons.lock,
                      ispassword: ispass,
                      suffixpressed: () {
                        setState(() {
                          ispass = !ispass;
                        });
                      },
                      suffix: ispass ? Icons.visibility : Icons.visibility_off),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: "login",
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(email.text);
                        print(password.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: "register",
                    function: () {
                      if (formKey.currentState!.validate()) print(email.text);
                      print(password.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have an account?'),
                      TextButton(
                          onPressed: () {}, child: const Text("Register Now"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
