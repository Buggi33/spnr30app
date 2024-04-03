import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 5,
        centerTitle: true,
        title: const Text("P R O F I L"),
      ),
//create stream reading Users collection
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
//get Users collection from firestore
          if (snapshot.hasData) {
//catch Users collection in app
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
//profile picture
                const Icon(
                  Icons.emoji_people,
                  size: 100,
                ),
                const SizedBox(height: 30),
//username
                Text(
                  userData['username'],
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
//kidname
                Text(
                  userData['kidname'],
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
//email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
