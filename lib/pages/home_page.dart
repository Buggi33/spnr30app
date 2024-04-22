import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spnr30app/components/my_drawer.dart';
import 'package:spnr30app/components/my_dropdown_button.dart';
import 'package:spnr30app/components/my_textfield.dart';
import 'package:spnr30app/components/my_wall.dart';
import 'package:spnr30app/helper/helper_date_format.dart';
import 'package:spnr30app/providers/checkbox_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  String dropdownValue = "Suns";

  @override
  void initState() {
    super.initState();
    _textFocusNode
        .unfocus(); // Unfocus pola tekstowego przy wejściu na stronę 1/2
  }

  @override
  void dispose() {
    textController.dispose();
    _textFocusNode.dispose();
    super.dispose(); //2/2
  }

  void _handleTap() {
    if (_textFocusNode.hasFocus) {
      _textFocusNode.unfocus(); // Jeśli pole jest zaznaczone, odznacz je
    }
  }

// Metoda łącząca strumienie z trzech kolekcji
  Stream<List<QuerySnapshot>> mergeStreams() {
    final checkboxProvider = Provider.of<CheckboxProvider>(context);
    final List<bool> checkboxValues =
        checkboxProvider.getCurrentCheckboxValues();
    final Stream<QuerySnapshot> sunsStream = checkboxValues[0]
        ? FirebaseFirestore.instance
            .collection("SunsPosts")
            .orderBy("TimeStamp", descending: true)
            .snapshots()
        : const Stream.empty();

    final Stream<QuerySnapshot> owlsStream = checkboxValues[1]
        ? FirebaseFirestore.instance
            .collection("OwlsPosts")
            .orderBy("TimeStamp", descending: true)
            .snapshots()
        : const Stream.empty();

    final Stream<QuerySnapshot> frogsStream = checkboxValues[2]
        ? FirebaseFirestore.instance
            .collection("FrogsPosts")
            .orderBy("TimeStamp", descending: true)
            .snapshots()
        : const Stream.empty();

    final streamsToCombine = <Stream<QuerySnapshot>>[];
    if (checkboxValues[0]) streamsToCombine.add(sunsStream);
    if (checkboxValues[1]) streamsToCombine.add(owlsStream);
    if (checkboxValues[2]) streamsToCombine.add(frogsStream);

    return Rx.combineLatest(
        streamsToCombine, (List<QuerySnapshot> snapshots) => snapshots);
  }

// //sign user out
//   void signOut() {
//     FirebaseAuth.instance.signOut();
//   }

//current user
  final currentUser = FirebaseAuth.instance.currentUser!;

//---------------------------------ADD POST SUNS-------------------------------
//add a post
  void addSunsPost() async {
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
        FirebaseFirestore.instance.collection('SunsPosts').add(
          {
            'Group': dropdownValue,
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

//---------------------------------ADD POST OWLS-------------------------------
//add a post
  void addOwlsPost() async {
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
        FirebaseFirestore.instance.collection('OwlsPosts').add(
          {
            'Group': dropdownValue,
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

//---------------------------------ADD POST FROGS------------------------------
//add a post
  void addFrogsPost() async {
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
        FirebaseFirestore.instance.collection('FrogsPosts').add(
          {
            'Group': dropdownValue,
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
    return GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          foregroundColor: Colors.grey[700],
          title: const Text("H O M E"),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          shadowColor: Colors.black,
          elevation: 5,
          //         actions: [
          // // sign out button
          //           // IconButton(
          //           //   onPressed: signOut,
          //           //   icon: const Icon(Icons.logout),
          //           // )
          //         ],
        ),
        //drawer
        drawer: const MyDrawer(),
        //wall
        body: Center(
          child: Column(
            children: [
              Expanded(
                //get all posts from firestore
                //StreamBuilder
                child: StreamBuilder<List<QuerySnapshot>>(
                  stream: mergeStreams(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                    }

                    final allDocs = <QueryDocumentSnapshot>[];

                    //add all streams together
                    for (final querySnapshot in snapshot.data!) {
                      allDocs.addAll(querySnapshot.docs);
                    }
                    //sorting all docs by TimeStamp
                    allDocs.sort((a, b) => (b['TimeStamp'] as Timestamp)
                        .compareTo(a['TimeStamp'] as Timestamp));

                    return RefreshIndicator(
                      color: Colors.grey,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        mergeStreams();
                      },
                      child: ListView.builder(
                        itemCount: allDocs.length,
                        itemBuilder: (_, index) {
                          final post = allDocs[index];
                          return MyWall(
                            group: post['Group'],
                            postmessage: post['PostMessage'],
                            email: post['UserEmail'],
                            username: post['Username'],
                            postId: post.id,
                            likes: List<String>.from(post['Likes'] ?? []),
                            time: formatDate(post['TimeStamp']),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              //post message sector
              Container(
                height: 1,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 25.0, right: 25, bottom: 25),
                child: Column(
                  children: [
                    //dropdown button
                    MyDropdownButton(
                      value: dropdownValue,
                      onChangedMDB: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                    // Container(
                    //   child: Text(dropdownValue),
                    // ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        //options field
                        //text field
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyTextField(
                            focusNode: _textFocusNode, //odznacza textfield
                            keybordType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            controller: textController,
                            hintText: "Napisz coś..",
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //send button
                        IconButton(
                          onPressed: () {
                            if (dropdownValue == 'Suns') {
                              addSunsPost();
                            } else if (dropdownValue == "Owls") {
                              addOwlsPost();
                            } else if (dropdownValue == "Frogs") {
                              addFrogsPost();
                            }
                            FocusScope.of(context).unfocus();
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[400],
                            ),
                            child: const Icon(Icons.done, size: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Text("Zalogowany jako: ${currentUser.email!}"),
            ],
          ),
        ),
      ),
    );
  }
}
