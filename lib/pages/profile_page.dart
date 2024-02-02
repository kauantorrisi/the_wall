import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:the_wall/components/text_box.dart';
import 'package:the_wall/utils/helper_functions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    Future<void> editField(String field) async {
      String newValue = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Editar $field',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Digite um novo $field',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text('Salvar'),
            ),
          ],
        ),
      );

      if (newValue.isNotEmpty) {
        await usersCollection.doc(currentUser!.email).update({field: newValue});
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.person, size: 72),
                  const SizedBox(height: 50),
                  Text(
                    '${currentUser!.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Informações:',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  MyTextBox(
                    onPressed: () => editField('username'),
                    text: userData['username'],
                    sectionName: 'nome de usuário',
                  ),
                  MyTextBox(
                    onPressed: () => editField('bio'),
                    text: userData['bio'],
                    sectionName: 'bio',
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Meus posts:',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return const Text('post');
                    },
                  )
                ],
              );
            } else if (snapshot.hasError) {
              displayMessageToUser(context, 'Error${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
