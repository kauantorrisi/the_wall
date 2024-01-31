// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wall/components/button.dart';
import 'package:the_wall/components/row_button.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/utils/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final Function()? recoveryPasswordOnTap;
  final Function()? registerOnTap;
  const LoginPage({
    super.key,
    required this.recoveryPasswordOnTap,
    required this.registerOnTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textEmailController = TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: textEmailController.text,
        password: textPasswordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      switch (e.code) {
        case 'invalid-email':
          displayMessageToUser(context, 'O email digitado é inválido!');
        case 'user-not-found':
          displayMessageToUser(context, 'Este usuário não existe!');
        case 'wrong-password':
          displayMessageToUser(context, 'A senha digitada está incorreta!');
        case 'user-disable':
          displayMessageToUser(context, 'Esse usuário foi desativado!');
        case 'invalid-credential':
          displayMessageToUser(
              context, 'O email ou senha digitados estão incorretos!');
        case 'channel-error':
          displayMessageToUser(context, 'Digite seu email e senha!');
        default:
          displayMessageToUser(context, e.code);
      }
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
                  const Text("Bem vindo(a) de volta, sentimos sua falta!"),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: textEmailController,
                    hintText: 'Email',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: textPasswordController,
                    hintText: 'Senha',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 10),

                  // sign in button
                  MyButton(
                    text: 'Login',
                    onTap: login,
                  ),

                  // forget password
                  RowButton(
                    onTap: widget.recoveryPasswordOnTap,
                    text: 'Esqueceu sua senha?',
                    textOfButton: 'Recupere aqui!',
                  ),

                  // go to register page
                  RowButton(
                    onTap: widget.registerOnTap,
                    text: 'Não tem uma conta?',
                    textOfButton: 'Registre-se aqui!',
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
