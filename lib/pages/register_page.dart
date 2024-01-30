// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wall/components/button.dart';
import 'package:the_wall/components/row_button.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textConfirmEmailController =
      TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();
  final TextEditingController textConfirmPasswordController =
      TextEditingController();

  void register() async {
    showDialog(
      context: context,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (textEmailController.text == textConfirmEmailController.text &&
        textPasswordController.text == textConfirmPasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: textEmailController.text,
          password: textPasswordController.text,
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        switch (e.code) {
          case 'email-already-in-use':
            displayMessageToUser(context, 'Email já cadastrado!');
          case 'weak-password':
            displayMessageToUser(context, 'A senha precisa ser mais forte!');
          case 'invalid-email':
            displayMessageToUser(context, 'Digite um email válido!');
          default:
            displayMessageToUser(context, e.code);
        }
      }
    } else {
      Navigator.pop(context);
      displayMessageToUser(
        context,
        'O email e senha precisam ser iguais nos campos de confirmação.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  const Text("Vamos criar uma conta para você!"),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: textEmailController,
                    hintText: 'Email',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 10),

                  // confirm email textfield
                  MyTextField(
                    controller: textConfirmEmailController,
                    hintText: 'Confirme o email',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: textPasswordController,
                    hintText: 'Senha',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 10),

                  // confirm password textfield
                  MyTextField(
                    controller: textConfirmPasswordController,
                    hintText: 'Confirme a senha',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 10),

                  // sign in button
                  MyButton(
                    text: 'Registrar',
                    onTap: register,
                  ),

                  // go to register page
                  RowButton(
                    onTap: widget.onTap,
                    text: 'Já tem uma conta?',
                    textOfButton: 'Faça login aqui!',
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
