import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

//sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
          MyListTile(
            icon: Icons.home,
            text: "H O M E",
            onTap: () => Navigator.pop(context),
          ),
//PROFIL (created by my_list_tile)
          MyListTile(
              icon: Icons.person,
              text: "P R O F I L",
              onTap: () {
                //pop drawer
                Navigator.pop(context);
                //navigate to profil page
                Navigator.pushNamed(context, '/profile_page');
              }),
//USERS (created by my_list_tile)
          MyListTile(
              icon: Icons.person,
              text: "U Ż Y T K O W N I C Y",
              onTap: () {
                //pop drawer
                Navigator.pop(context);
                //navigate to profil page
                Navigator.pushNamed(context, '/users_page');
              }),
//LOGOUT (created by my_list_tile)
          MyListTile(
            icon: Icons.logout,
            text: "W Y L O G U J",
            onTap: signOut,
          ),
        ],
      ),
    );
  }
}
