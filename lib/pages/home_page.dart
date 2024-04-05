import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_drawer.dart';
import 'package:spnr30app/components/my_textfield.dart';
import 'package:spnr30app/components/my_wall.dart';
import 'package:spnr30app/helper/helper_date_format.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
//sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

//current user
  final currentUser = FirebaseAuth.instance.currentUser!;

//add a post
  void addPost() async {
//add only when something is in text field
    if (textController.text.isNotEmpty) {
//search the 'username' in other collection (Users)
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();
      if (userSnapshot.exists) {
        String username =
            (userSnapshot.data() as Map<String, dynamic>)['username'];

//store in firestore
        FirebaseFirestore.instance.collection('Posts').add(
          {
            'UserEmail': currentUser.email,
            'PostMessage': textController.text,
            'Username': username,
            'TimeStamp': Timestamp.now(),
            'Likes': [],
          },
        );
      }
      setState(() {
        textController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H O M E"),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 5,
        actions: [
//sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
//drawer
      drawer: const MyDrawer(),
//wall
      body: Center(
        child: Column(
          children: [
            Expanded(
//get all posts from firestore
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Posts")
//sorting by newest
                    .orderBy(
                      "TimeStamp",
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
//build a list view
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
//get and show the posts
                        final post = snapshot.data!.docs[index];
                        return MyWall(
                          postmessage: post['PostMessage'],
                          email: post['UserEmail'],
                          username: post['Username'],
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                          time: formatDate(post['TimeStamp']),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Błąd: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
//post message sector
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
//text field
                  Expanded(
                    child: MyTextField(
                      keybordType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      controller: textController,
                      hintText: "Napisz coś..",
                      obscureText: false,
                    ),
                  ),
//send button
                  IconButton(
                    onPressed: () {
                      addPost();
                      FocusScope.of(context).unfocus();
                    },
                    icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[400],
                        ),
                        child: const Icon(Icons.done)),
                  ),
                ],
              ),
            ),
            Text("Zalogowany jako: ${currentUser.email!}"),
          ],
        ),
      ),
    );
  }
}
