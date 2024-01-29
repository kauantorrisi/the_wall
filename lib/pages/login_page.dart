import 'package:flutter/material.dart';

import 'package:the_wall/components/button.dart';
import 'package:the_wall/components/row_button.dart';
import 'package:the_wall/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back message
                const Text("Bem vindo(a) de volta, sentimos sua falta!"),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: textEmailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: textPasswordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // sign in button
                MyButton(
                  text: 'Login',
                  onTap: () {},
                ),

                // forget password
                RowButton(
                  onTap: () {},
                  text: 'Esqueceu sua senha?',
                  textOfButton: 'Recupere aqui!',
                ),

                // go to register page
                RowButton(
                  onTap: () {},
                  text: 'Não tem uma conta?',
                  textOfButton: 'Registre-se aqui!',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
