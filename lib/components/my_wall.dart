import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_comment_button.dart';
import 'package:spnr30app/components/my_delete_button.dart';
import 'package:spnr30app/components/my_like_button.dart';
import 'package:spnr30app/components/my_comment.dart';
import 'package:spnr30app/helper/helper_date_format.dart';

class MyWall extends StatefulWidget {
  final String postmessage;
  final email;
  final String username;
  final String postId;
  final String time;
  final List<String> likes;

  const MyWall({
    super.key,
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

//initialize the status of actual statewidget
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

//toggle the Likes
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

//access the document
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Posts').doc(widget.postId);

    if (isLiked) {
//if the post is now liked, add current email to the 'Likes' collection
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
//if the post is now unliked, remove current email from 'Likes' collection
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

//add a comment
  Future<void> addComment(String commentText) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();
    if (userSnapshot.exists) {
      String username =
          (userSnapshot.data() as Map<String, dynamic>)['username'];

      //write comment to firestore as Comment collection
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentText": commentText,
        "CommentedBy": username,
        "CommentEmail": currentUser.email,
        "CommentTime": Timestamp.now(),
      });
    }
  }

//show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Dodaj komentarz"),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(hintText: "Napisz komentarz.."),
        ),
        actions: [
//add comment button
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              //pop box
              Navigator.pop(context);
              //clear textfild/controller
              _commentTextController.clear();
            },
            child: const Text("Dodaj"),
          ),
//cancel button
          TextButton(
            onPressed: () {
              //pop box
              Navigator.pop(context);
              //clear textfild/controller
              _commentTextController.clear();
            },
            child: const Text("Anuluj"),
          ),
        ],
      ),
    );
  }

//delete the post
  void deletePost() async {
//show dialog box to confirm delete
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuń Post'),
        content: const Text('Czy na pewno chcesz usunąć post?'),
        actions: [
//delete button
          TextButton(
            onPressed: () async {
//delete the comments from firestore as first
              final commentDocs = await FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .get();

              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection('Posts')
                    .doc(widget.postId)
                    .collection('Comments')
                    .doc(doc.id)
                    .delete();
              }
//delete the post from firestore as second
              FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(widget.postId)
                  .delete();
//pop box
              Navigator.pop(context);
            },
            child: const Text("Usuń"),
          ),
//cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Anuluj"),
          ),
        ],
      ),
    );
    // print(
    //     'Email bieżącego użytkownika "currentUser.email": ${currentUser.email}');
    // print('Nazwa użytkownika postu "widget.username": ${widget.username}');
    // print('Nazwa użytkownika postu "widget.email": ${widget.email}');
  }

  @override
  Widget build(BuildContext context) {
//get from firebase all comments
    Stream<QuerySnapshot> countStream = FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.postId)
        .collection('Comments')
        .snapshots();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//post message
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.postmessage),
                    const SizedBox(height: 10),
                    Row(
                      children: [
//post username
                        Text(
                          widget.username,
                          style: const TextStyle(color: Colors.grey),
                        ),
//cosmetic space between
                        const Text("  "),
//post time
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
                  onTap: deletePost,
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
                    style: TextStyle(color: Colors.grey[700]),
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
                  StreamBuilder(
                    stream: countStream,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('No Data');
                      }
                      int docCount = snapshot.data != null
                          ? snapshot.data!.docs.length
                          : 0;
                      return Text(
                        docCount.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
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
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .doc(widget.postId)
                .collection('Comments')
                .orderBy("CommentTime", descending: false)
                .snapshots(),
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
