import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_comment_button.dart';
import 'package:spnr30app/components/my_delete_button.dart';
import 'package:spnr30app/components/my_like_button.dart';
import 'package:spnr30app/components/my_comment.dart';
import 'package:spnr30app/helper/helper_date_format.dart';

class MyWall extends StatefulWidget {
  final String group;
  final String postmessage;
  final email;
  final String username;
  final String postId;
  final String time;
  final List<String> likes;

  const MyWall({
    super.key,
    required this.group,
    required this.postmessage,
    required this.email,
    required this.username,
    required this.likes,
    required this.postId,
    required this.time,
  });

  @override
  State<MyWall> createState() => _MyWallState();
}

class _MyWallState extends State<MyWall> {
//take user from firebase
  final currentUser = FirebaseAuth.instance.currentUser!;

//comment text controller
  final _commentTextController = TextEditingController();
//
  bool isLiked = false;
//color of groups
  Color getColorForGroup(String group) {
    switch (group) {
      case 'Suns':
        return Colors.yellow[800] ?? Colors.yellow;
      case 'Owls':
        return Colors.brown;
      case 'Frogs':
        return Colors.green;
      default:
        return Colors.black; // domyślny kolor
    }
  }

  Stream<QuerySnapshot> _getCommentsStream() {
    if (widget.group == 'Suns') {
      return FirebaseFirestore.instance
          .collection('SunsPosts')
          .doc(widget.postId)
          .collection('Comments')
          .orderBy("CommentTime", descending: false)
          .snapshots();
    } else if (widget.group == 'Owls') {
      return FirebaseFirestore.instance
          .collection('OwlsPosts')
          .doc(widget.postId)
          .collection('Comments')
          .orderBy("CommentTime", descending: false)
          .snapshots();
    } else if (widget.group == 'Frogs') {
      return FirebaseFirestore.instance
          .collection('FrogsPosts')
          .doc(widget.postId)
          .collection('Comments')
          .orderBy("CommentTime", descending: false)
          .snapshots();
    }
    // Domyślnie zwracamy pusty strumień, jeśli nie pasuje do żadnej grupy
    return const Stream.empty();
  }

//initialize the status of actual statewidget
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

//--------------------------A D D I N G   L I K E S----------------------------
//---------------------------------S U N S-------------------------------------
//toggle the Likes
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
//access the document of SunsPosts
    DocumentReference sunsPostRef =
        FirebaseFirestore.instance.collection('SunsPosts').doc(widget.postId);

    if (isLiked) {
//if the post is now liked, add current email to the 'Likes' collection
      sunsPostRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
//if the post is now unliked, remove current email from 'Likes' collection
      sunsPostRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }

//---------------------------------O W L S-------------------------------------
//access the document of SunsPosts
    DocumentReference owlsPostRef =
        FirebaseFirestore.instance.collection('OwlsPosts').doc(widget.postId);

    if (isLiked) {
//if the post is now liked, add current email to the 'Likes' collection
      owlsPostRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
//if the post is now unliked, remove current email from 'Likes' collection
      owlsPostRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }

//---------------------------------F R O G S-----------------------------------

//access the document of SunsPosts
    DocumentReference frogsPostRef =
        FirebaseFirestore.instance.collection('FrogsPosts').doc(widget.postId);

    if (isLiked) {
//if the post is now liked, add current email to the 'Likes' collection
      frogsPostRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
//if the post is now unliked, remove current email from 'Likes' collection
      frogsPostRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

//----------------------------A D D  C O M M E N T S---------------------------
//----------------------------------S U N S------------------------------------
//add a comment
  Future<void> addSunsComment(String commentText) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();
    if (userSnapshot.exists) {
      String username =
          (userSnapshot.data() as Map<String, dynamic>)['username'];

//write comment to firestore as Comment collection
      FirebaseFirestore.instance
          .collection('SunsPosts')
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentGroup": widget.group,
        "CommentText": commentText,
        "CommentedBy": username,
        "CommentEmail": currentUser.email,
        "CommentTime": Timestamp.now(),
      });
    }
  }

//----------------------------------O W L S------------------------------------
//add a comment
  Future<void> addOwlsComment(String commentText) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();
    if (userSnapshot.exists) {
      String username =
          (userSnapshot.data() as Map<String, dynamic>)['username'];

//write comment to firestore as Comment collection
      FirebaseFirestore.instance
          .collection('OwlsPosts')
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentGroup": widget.group,
        "CommentText": commentText,
        "CommentedBy": username,
        "CommentEmail": currentUser.email,
        "CommentTime": Timestamp.now(),
      });
    }
  }

//---------------------------------F R O G S-----------------------------------
//add a comment
  Future<void> addFrogsComment(String commentText) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();
    if (userSnapshot.exists) {
      String username =
          (userSnapshot.data() as Map<String, dynamic>)['username'];

//write comment to firestore as Comment collection
      FirebaseFirestore.instance
          .collection('FrogsPosts')
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentGroup": widget.group,
        "CommentText": commentText,
        "CommentedBy": username,
        "CommentEmail": currentUser.email,
        "CommentTime": Timestamp.now(),
      });
    }
  }

//-----------------------------------------------------------------------------
//show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[300],
        titlePadding: const EdgeInsets.only(left: 50, top: 30),
        title: Text(
            style: TextStyle(
              color: Colors.grey[700],
            ),
            "Dodaj komentarz"),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(
            hintText: "Napisz komentarz..",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        actions: [
//add comment button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (widget.group == "Suns") {
                    addSunsComment(_commentTextController.text);
                  } else if (widget.group == "Owls") {
                    addOwlsComment(_commentTextController.text);
                  } else if (widget.group == "Frogs") {
                    addFrogsComment(_commentTextController.text);
                  }
                  //pop box
                  Navigator.pop(context);
                  //clear textfild/controller
                  _commentTextController.clear();
                },
                child: Text(
                  "Dodaj",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              //cancel button
              TextButton(
                onPressed: () {
                  //pop box
                  Navigator.pop(context);
                  //clear textfild/controller
                  _commentTextController.clear();
                },
                child: Text(
                  "Anuluj",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//---------------------------D E L E T I N G  P O S T S------------------------
//----------------------------------S U N S------------------------------------
//delete the post
  void deleteSunsPost() async {
//show dialog box to confirm delete
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[300],
        titlePadding: const EdgeInsets.only(left: 85, top: 30),
        title: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Usuń Post',
        ),
        content: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Czy na pewno chcesz usunąć post?',
        ),
        actions: [
//delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  //delete the comments from firestore as first
                  final commentDocs = await FirebaseFirestore.instance
                      .collection("SunsPosts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .get();

                  for (var doc in commentDocs.docs) {
                    await FirebaseFirestore.instance
                        .collection('SunsPosts')
                        .doc(widget.postId)
                        .collection('Comments')
                        .doc(doc.id)
                        .delete();
                  }
                  //delete the post from firestore as second
                  FirebaseFirestore.instance
                      .collection("SunsPosts")
                      .doc(widget.postId)
                      .delete();
                  //pop box
                  Navigator.pop(context);
                },
                child: const Text(
                  "Usuń",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              //cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Anuluj",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // print(
    //     'Email bieżącego użytkownika "currentUser.email": ${currentUser.email}');
    // print('Nazwa użytkownika postu "widget.username": ${widget.username}');
    // print('Nazwa użytkownika postu "widget.email": ${widget.email}');
  }

//----------------------------------O W L S------------------------------------
//delete the post
  void deleteOwlsPost() async {
//show dialog box to confirm delete
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[300],
        titlePadding: const EdgeInsets.only(left: 85, top: 30),
        title: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Usuń Post',
        ),
        content: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Czy na pewno chcesz usunąć post?',
        ),
        actions: [
//delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  //delete the comments from firestore as first
                  final commentDocs = await FirebaseFirestore.instance
                      .collection("OwlsPosts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .get();

                  for (var doc in commentDocs.docs) {
                    await FirebaseFirestore.instance
                        .collection('OwlsPosts')
                        .doc(widget.postId)
                        .collection('Comments')
                        .doc(doc.id)
                        .delete();
                  }
                  //delete the post from firestore as second
                  FirebaseFirestore.instance
                      .collection("OwlsPosts")
                      .doc(widget.postId)
                      .delete();
                  //pop box
                  Navigator.pop(context);
                },
                child: const Text(
                  "Usuń",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              //cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Anuluj",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//---------------------------------F R O G S-----------------------------------
//delete the post
  void deleteFrogsPost() async {
//show dialog box to confirm delete
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[300],
        titlePadding: const EdgeInsets.only(left: 85, top: 30),
        title: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Usuń Post',
        ),
        content: Text(
          style: TextStyle(color: Colors.grey[700]),
          'Czy na pewno chcesz usunąć post?',
        ),
        actions: [
//delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  //delete the comments from firestore as first
                  final commentDocs = await FirebaseFirestore.instance
                      .collection("FrogsPosts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .get();

                  for (var doc in commentDocs.docs) {
                    await FirebaseFirestore.instance
                        .collection('FrogsPosts')
                        .doc(widget.postId)
                        .collection('Comments')
                        .doc(doc.id)
                        .delete();
                  }
                  //delete the post from firestore as second
                  FirebaseFirestore.instance
                      .collection("FrogsPosts")
                      .doc(widget.postId)
                      .delete();
                  //pop box
                  Navigator.pop(context);
                },
                child: const Text(
                  "Usuń",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              //cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Anuluj",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
//get from firebase all comments for counting comments
    Stream<QuerySnapshot> countSunsStream = FirebaseFirestore.instance
        .collection('SunsPosts')
        .doc(widget.postId)
        .collection('Comments')
        .snapshots();
//get from firebase all comments for counting comments
    Stream<QuerySnapshot> countOwlsStream = FirebaseFirestore.instance
        .collection('OwlsPosts')
        .doc(widget.postId)
        .collection('Comments')
        .snapshots();
//get from firebase all comments for counting comments
    Stream<QuerySnapshot> countFrogsStream = FirebaseFirestore.instance
        .collection('FrogsPosts')
        .doc(widget.postId)
        .collection('Comments')
        .snapshots();

    String groupName = '';

    if (widget.group == 'Suns') {
      groupName = 'S Ł O N E C Z K A';
    } else if (widget.group == 'Owls') {
      groupName = 'S Ó W K I';
    } else if (widget.group == 'Frogs') {
      groupName = 'Ż A B K I';
    } else {
      // Obsługa przypadku, gdy wartość group nie pasuje do żadnego z powyższych
      groupName = 'Nieznana grupa';
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            )
          ]),
      margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
      padding: const EdgeInsets.all(10),
      child:
//post
          Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//post group text
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        groupName,
                        style: TextStyle(
                          color: getColorForGroup(widget.group),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
//post text
                    Text(widget.postmessage),
                    const SizedBox(height: 10),
                    Row(
                      children: [
//post username text
                        Text(
                          widget.username,
                          style: const TextStyle(color: Colors.grey),
                        ),
//cosmetic space between
                        const Text("  "),
//post time text
                        Text(
                          widget.time,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
//delete button
              if (currentUser.email == widget.email)
                MyDeleteButton(
                  size: 23,
                  onTap: () {
                    if (widget.group == "Suns") {
                      deleteSunsPost();
                    } else if (widget.group == "Owls") {
                      deleteOwlsPost();
                    } else if (widget.group == "Frogs") {
                      deleteFrogsPost();
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
// L I K E
//like button
              Column(
                children: [
                  MyLikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
//like count
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
// C O M M E N T
//comment button
              Column(
                children: [
                  MyCommentButton(
                    onTap: showCommentDialog,
                  ),
//comment count
//StreamBuilder dla Słoneczka
                  if (widget.group == 'Suns')
                    StreamBuilder(
                      stream: countSunsStream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('No Data');
                        }
                        int docCount = snapshot.data != null
                            ? snapshot.data!.docs.length
                            : 0;
                        return Text(
                          docCount.toString(),
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        );
                      }),
                    ),
//StreamBuilder dla Sówki
                  if (widget.group == 'Owls')
                    StreamBuilder(
                      stream: countOwlsStream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('No Data');
                        }
                        int docCount = snapshot.data != null
                            ? snapshot.data!.docs.length
                            : 0;
                        return Text(
                          docCount.toString(),
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        );
                      }),
                    ),
//StreamBuilder dla Żabki
                  if (widget.group == 'Frogs')
                    StreamBuilder(
                      stream: countFrogsStream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('No Data');
                        }
                        int docCount = snapshot.data != null
                            ? snapshot.data!.docs.length
                            : 0;
                        return Text(
                          docCount.toString(),
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
// showing comment under the post
          StreamBuilder<QuerySnapshot>(
            stream: _getCommentsStream()
            // FirebaseFirestore.instance
            //     .collection('Posts')
            //     .doc(widget.postId)
            //     .collection('Comments')
            //     .orderBy("CommentTime", descending: false)
            //     .snapshots()
            ,
            builder: (context, snapshot) {
//showing the loading circle if no date
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
// if data show as list
              return ListView(
                shrinkWrap:
                    true, //good idea when have list inside the partent widget
                physics: const NeverScrollableScrollPhysics(),
                // physics: const AlwaysScrollableScrollPhysics(),
                children: snapshot.data!.docs.map(
                  (doc) {
                    final commentData = doc.data() as Map<String, dynamic>;
                    final commentId = doc.reference.id;
                    return MyComment(
                      group: widget.group,
                      cmtEmail: commentData['CommentEmail'],
                      postId: widget.postId,
                      commentId: commentId,
                      text: commentData['CommentText'],
                      username: commentData['CommentedBy'],
                      time: formatDate(commentData['CommentTime']),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
