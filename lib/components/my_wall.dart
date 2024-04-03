import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_delete_button.dart';
import 'package:spnr30app/components/my_like_button.dart';

class MyWall extends StatefulWidget {
  final String postmessage;
  final String username;
  final String postId;
  final List<String> likes;

  const MyWall({
    super.key,
    required this.postmessage,
    required this.username,
    required this.likes,
    required this.postId,
  });

  @override
  State<MyWall> createState() => _MyWallState();
}

class _MyWallState extends State<MyWall> {
//take user from firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
//like button
              Row(
                children: [
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
                    width: 5,
                  ),
//comment counts
                  Column(
                    children: [
                      Icon(Icons.message, color: Colors.grey[600]),
                      const Text('0'),
                    ],
                  ),
                ],
              ),
            ],
          ),
//post and username
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.postmessage),
                const SizedBox(height: 10),
                Text(
                  widget.username,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          MyDeleteButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
