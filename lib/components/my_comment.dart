import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_delete_button.dart';

class MyComment extends StatefulWidget {
  final String text;
  final String username;
  final String time;
  final String postId;
  final String commentId;
  final String cmtEmail;
  final String group;
  const MyComment({
    super.key,
    required this.text,
    required this.time,
    required this.username,
    required this.commentId,
    required this.postId,
    required this.cmtEmail,
    required this.group,
  });

  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
//current user
  final currentUser = FirebaseAuth.instance.currentUser!;

//---------------------------------DELETE COMMENTS------------------------------
//-----------------------------------S U N S -----------------------------------
  void deleteSunsComment() async {
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
                        //delete the comment from firestore
                        await FirebaseFirestore.instance
                            .collection('SunsPosts')
                            .doc(widget.postId)
                            .collection('Comments')
                            .doc(widget.commentId)
                            .delete();
                        //pop box
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Usuń',
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
            ));
    // print('currentUser.email: ${currentUser.email}');
    // print('widget.email: ${widget.cmtEmail}');
    print('widget.group: ${widget.group}');
  }

//---------------------------------DELETE COMMENTS------------------------------
//-----------------------------------O W L S=-----------------------------------
  void deleteOwlsComment() async {
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
                        //delete the comment from firestore
                        await FirebaseFirestore.instance
                            .collection('OwlsPosts')
                            .doc(widget.postId)
                            .collection('Comments')
                            .doc(widget.commentId)
                            .delete();
                        //pop box
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Usuń',
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
            ));
    // print('currentUser.email: ${currentUser.email}');
    // print('widget.email: ${widget.cmtEmail}');
    print('widget.group: ${widget.group}');
  }

//---------------------------------DELETE COMMENTS------------------------------
//-----------------------------------F R O G S----------------------------------
  void deleteFrogsComment() async {
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
                        //delete the comment from firestore
                        await FirebaseFirestore.instance
                            .collection('FrogsPosts')
                            .doc(widget.postId)
                            .collection('Comments')
                            .doc(widget.commentId)
                            .delete();
                        //pop box
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Usuń',
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
            ));
    // print('currentUser.email: ${currentUser.email}');
    // print('widget.email: ${widget.cmtEmail}');
    print('widget.group: ${widget.group}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //comment text
                Text(
                  widget.text,
                  maxLines: null,
                  // overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                //comment sector of username and time
                Row(
                  children: [
                    //comment username
                    Text(
                      widget.username,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    //cosmetic space between
                    const Text("  "),
                    //comment time
                    Text(
                      widget.time,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (currentUser.email == widget.cmtEmail)
            MyDeleteButton(
                size: 18,
                onTap: () {
                  if (widget.group == 'Suns') {
                    deleteSunsComment();
                  } else if (widget.group == 'Owls') {
                    deleteOwlsComment();
                  } else if (widget.group == 'Frogs') {
                    deleteFrogsComment();
                  }
                }),
        ],
      ),
    );
  }
}
