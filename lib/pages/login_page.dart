import 'package:flutter/material.dart';
import 'package:the_wall/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const SafeArea(
        child: Center(
          child: Column(
            children: [
              // logo
              SizedBox(height: 50),
              Icon(
                Icons.lock,
                size: 100,
              ),

              // welcome back message
              SizedBox(height: 50),
              Text("Bem vindo(a) de volta, sentimos sua falta"),
              SizedBox(height: 25),

              // email textfield
              MyTextField(),

              // password textfield
              MyTextField(),

              // sign in button

              // go to register page
            ],
          ),
        ),
      ),
    );
  }
}
