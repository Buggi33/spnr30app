import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spnr30app/components/my_checkbox_frogs_button.dart';
import 'package:spnr30app/components/my_checkbox_owls_button.dart';
import 'package:spnr30app/components/my_checkbox_suns_button.dart';
import 'package:spnr30app/components/my_textfield.dart';
import 'package:spnr30app/providers/checkbox_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//current user
  final currentUser = FirebaseAuth.instance.currentUser!;

//text controller
  final _pwdTxtController1 = TextEditingController();
  final _pwdTxtController2 = TextEditingController();
  final _pwdTxtController3 = TextEditingController();

//mycheckboxbutton
  bool isSwitchedSuns = false;
  bool isSwitchedOwls = false;
  bool isSwitchedFrogs = false;

  @override
  void initState() {
    super.initState();
    compareFrogsPasswords();
    compareOwlsPasswords();
    compareSunsPasswords();
  }

//-------------------------------SUNS FUNCTION------------------------------
//funkcja porównująca dwie wartości
  void compareSunsPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (_pwdTxtController1.text.isNotEmpty) {
        try {
          String sPw = _pwdTxtController1.text;
          prefs.setString('sPw', sPw);
          print('Dodane do bazy: $sPw');
          _pwdTxtController1.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
      String? sPwSaved = prefs.getString('sPw');
// Porównaj obydwie wartości
      if (sPwSaved == 'sunsEmpire') {
        print('Wartości są takie same.');
        setState(() {
          isSwitchedSuns = true;
        });
      } else {
        print('Wartości są różne.');
        isSwitchedSuns = false;
      }
    } catch (e) {
      print('Błąd: $e');
    }
  }

//-------------------------------OWLS FUNCTION-----------------------------
//funkcja porównująca dwie wartości
  void compareOwlsPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (_pwdTxtController2.text.isNotEmpty) {
        try {
          String oPw = _pwdTxtController2.text;
          prefs.setString('oPw', oPw);
          print('Dodane do bazy: $oPw');
          _pwdTxtController2.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
      String? oPwSaved = prefs.getString('oPw');
// Porównaj obydwie wartości
      if (oPwSaved == 'owlsForest') {
        print('Wartości są takie same.');
        setState(() {
          isSwitchedOwls = true;
        });
      } else {
        print('Wartości są różne.');
        isSwitchedOwls = false;
      }
    } catch (e) {
      print('Błąd: $e');
    }
  }

//-------------------------------FROGS FUNCTION----------------------------
//funkcja porównująca dwie wartości
  void compareFrogsPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (_pwdTxtController3.text.isNotEmpty) {
        try {
          String fPw = _pwdTxtController3.text;
          prefs.setString('fPw', fPw);
          print('Dodane do bazy: $fPw');
          _pwdTxtController3.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
      String? fPwSaved = prefs.getString('fPw');
// Porównaj obydwie wartości
      if (fPwSaved == 'frogsLake') {
        print('Wartości są takie same.');
        setState(() {
          isSwitchedFrogs = true;
        });
      } else {
        print('Wartości są różne.');
        isSwitchedFrogs = false;
      }
    } catch (e) {
      print('Błąd: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkboxProvider = Provider.of<CheckboxProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 245, 26, 64),
        backgroundColor: const Color.fromARGB(255, 0, 39, 73),
        shadowColor: Colors.black,
        elevation: 5,
        centerTitle: true,
        title: const Text("P R O F I L"),
      ),
//create stream reading Users collection
      body: SingleChildScrollView(
        reverse: true, //pozwala przewijać ekran przy wysuniętej
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(currentUser.email)
                  .snapshots(),
              builder: (context, snapshot) {
//get Users collection from firestore
                if (snapshot.hasData) {
//catch Users collection in app
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
//profile picture
                        const Icon(
                          Icons.emoji_people,
                          size: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 30),
//username
                        Text(
                          userData['username'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 245, 26, 64)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
//kidname
                        // Text(
                        //   userData['kidname'],
                        //   textAlign: TextAlign.center,
                        // ),
                        // const SizedBox(height: 10),
//email
                        Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 245, 26, 64)),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
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
//------------------------------C H E C K B O X E S--------------------------
//checkbox suns
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 62,
                          width: 180,
                          child: MyCheckboxSunsButton(
                            isSwitchedSuns: isSwitchedSuns,
                            title: SizedBox(
                              height: 30,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                      'assets/images/sloneczka.png')),
                            ),
                            value: checkboxProvider.isCheckedSuns,
                            onChanged: (newValue) {
                              checkboxProvider.toggleCBSuns();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        width: 125,
                        child: Center(
                          child: MyTextField(
                            style: TextStyle(color: Colors.blue[800]),
                            keybordType: TextInputType.multiline,
                            maxLines: 1,
                            controller: _pwdTxtController1,
                            hintText: 'Hasło',
                            obscureText: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          onPressed: compareSunsPasswords,
                          icon: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 245, 26, 64),
                            ),
                            child: const Icon(
                              color: Colors.white,
                              Icons.done,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
//checkbox owls
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 62,
                      width: 180,
                      child: MyCheckboxFrogsButton(
                        isSwitchedFrogs: isSwitchedOwls,
                        title: SizedBox(
                          height: 30,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('assets/images/sowki.png')),
                        ),
                        value: checkboxProvider.isCheckedOwls,
                        onChanged: (newValue) {
                          checkboxProvider.toggleCBOwls();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 125,
                    child: Center(
                      child: MyTextField(
                        style: TextStyle(color: Colors.blue[800]),
                        keybordType: TextInputType.multiline,
                        maxLines: 1,
                        controller: _pwdTxtController2,
                        hintText: 'Hasło',
                        obscureText: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: IconButton(
                      onPressed: compareOwlsPasswords,
                      icon: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 245, 26, 64),
                        ),
                        child: const Icon(
                          color: Colors.white,
                          Icons.done,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
//checkbox frogs
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 62,
                      width: 180,
                      child: MyCheckboxOwlsButton(
                        isSwitchedOwls: isSwitchedFrogs,
                        title: SizedBox(
                          height: 30,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('assets/images/zabki.png')),
                        ),
                        value: checkboxProvider.isCheckedFrogs,
                        onChanged: (newValue) {
                          checkboxProvider.toggleCBFrogs();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 125,
                    child: Center(
                      child: MyTextField(
                        style: TextStyle(color: Colors.blue[800]),
                        keybordType: TextInputType.multiline,
                        maxLines: 1,
                        controller: _pwdTxtController3,
                        hintText: 'Hasło',
                        obscureText: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: IconButton(
                      onPressed: compareFrogsPasswords,
                      icon: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 245, 26, 64),
                        ),
                        child: const Icon(
                          color: Colors.white,
                          Icons.done,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
