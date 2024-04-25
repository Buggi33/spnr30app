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
      backgroundColor: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
//header
              DrawerHeader(child: Image.asset('assets/images/LOGO_30_5.png')),
//HOME (created by my_list_tile)
              const SizedBox(height: 10),
              MyListTile(
                icon: Icons.home_outlined,
                iconColor: Colors.red,
                text: "H O M E",
                textColor: const Color.fromARGB(255, 23, 118, 197),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
//PROFIL (created by my_list_tile)
              MyListTile(
                  icon: Icons.person_outlined,
                  iconColor: Colors.red,
                  text: "P R O F I L",
                  textColor: const Color.fromARGB(255, 23, 118, 197),
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
                  iconColor: Colors.red,
                  text: "P Ł A T N O Ś C I",
                  textColor: const Color.fromARGB(255, 23, 118, 197),
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
                  iconColor: Colors.red,
                  text: "K O N T A K T",
                  textColor: const Color.fromARGB(255, 23, 118, 197),
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
              iconColor: const Color.fromARGB(255, 23, 118, 197),
              text: "W Y L O G U J",
              textColor: Colors.red,
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}
