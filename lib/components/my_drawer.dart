import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_list_tile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
//sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textFocusNode
        .unfocus(); // Unfocus pola tekstowego przy wejściu na stronę 1/2
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    super.dispose(); //2/2
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
//header
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
//HOME (created by my_list_tile)
              const SizedBox(height: 10),
              MyListTile(
                icon: Icons.home_outlined,
                text: "H O M E",
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
//PROFIL (created by my_list_tile)
              MyListTile(
                  icon: Icons.person_outlined,
                  text: "P R O F I L",
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to profil page
                    Navigator.pushNamed(context, '/profile_page');
                  }),
//USERS (created by my_list_tile)
              const SizedBox(height: 10),
              MyListTile(
                  icon: Icons.credit_card,
                  text: "P Ł A T N O Ś C I",
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to profil page
                    Navigator.pushNamed(context, '/users_page');
                  }),
//CONTACT (created by my_list_tile)
              const SizedBox(height: 10),
              MyListTile(
                  icon: Icons.contact_support_outlined,
                  text: "K O N T A K T",
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    //navigate to profil page
                    Navigator.pushNamed(context, '/contact_page');
                  }),
            ],
          ),
//LOGOUT (created by my_list_tile)
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: MyListTile(
              icon: Icons.logout,
              text: "W Y L O G U J",
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}
