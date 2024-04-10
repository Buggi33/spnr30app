import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_checkbox_frogs_button.dart';
import 'package:spnr30app/components/my_checkbox_owls_button.dart';
import 'package:spnr30app/components/my_checkbox_suns_button.dart';
import 'package:spnr30app/components/my_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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

//checkbox bool
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;

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
    try {
      if (_pwdTxtController1.text.isNotEmpty) {
        try {
//store in firebase
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .update({
            'sunsPassword': _pwdTxtController1.text,
          });
          print('Dane dodane do bazy');

          _pwdTxtController1.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
// Pobierz referencję do pierwszego dokumentu w pierwszej kolekcji
      DocumentSnapshot firstDocSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();
// Pobierz wartość z dokumentu
      String firstValue = firstDocSnapshot['sunsPassword'];

// Pobierz referencję do drugiego dokumentu w drugiej kolekcji
      DocumentSnapshot secondDocSnapshot = await FirebaseFirestore.instance
          .collection('GroupsPassword')
          .doc('passwordsID')
          .get();
// Pobierz wartość z dokumentu
      String secondValue = secondDocSnapshot['suns'];

      print('firstValue : $firstValue');
      print('secondValue : $secondValue');

// Porównaj obydwie wartości
      if (firstValue == secondValue) {
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
    try {
      if (_pwdTxtController2.text.isNotEmpty) {
        try {
//store in firebase
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .update({
            'owlsPassword': _pwdTxtController2.text,
          });
          print('Dane dodane do bazy');

          _pwdTxtController2.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
// Pobierz referencję do pierwszego dokumentu w pierwszej kolekcji
      DocumentSnapshot firstDocSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();
// Pobierz wartość z dokumentu
      String firstValue = firstDocSnapshot['owlsPassword'];

// Pobierz referencję do drugiego dokumentu w drugiej kolekcji
      DocumentSnapshot secondDocSnapshot = await FirebaseFirestore.instance
          .collection('GroupsPassword')
          .doc('passwordsID')
          .get();
// Pobierz wartość z dokumentu
      String secondValue = secondDocSnapshot['owls'];

      print('firstValue : $firstValue');
      print('secondValue : $secondValue');

// Porównaj obydwie wartości
      if (firstValue == secondValue) {
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
    try {
      if (_pwdTxtController3.text.isNotEmpty) {
        try {
//store in firebase
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .update({
            'frogsPassword': _pwdTxtController3.text,
          });
          print('Dane dodane do bazy');

          _pwdTxtController3.clear();
        } catch (e) {
          print('Błąd: $e');
        }
      }
// Pobierz referencję do pierwszego dokumentu w pierwszej kolekcji
      DocumentSnapshot firstDocSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();
      // Pobierz wartość z dokumentu
      String firstValue = firstDocSnapshot['frogsPassword'];

// Pobierz referencję do drugiego dokumentu w drugiej kolekcji
      DocumentSnapshot secondDocSnapshot = await FirebaseFirestore.instance
          .collection('GroupsPassword')
          .doc('passwordsID')
          .get();
// Pobierz wartość z dokumentu
      String secondValue = secondDocSnapshot['frogs'];

      print('firstValue : $firstValue');
      print('secondValue : $secondValue');

// Porównaj obydwie wartości
      if (firstValue == secondValue) {
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
    return Scaffold(
      appBar: AppBar(
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
                        ),
                        const SizedBox(height: 30),
//username
                        Text(
                          userData['username'],
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
//kidname
                        Text(
                          userData['kidname'],
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
//email
                        Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
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
                            value: _isChecked1,
                            title: SizedBox(
                              height: 30,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                      'assets/images/sloneczka.png')),
                            ),
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked1 = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        width: 125,
                        child: Center(
                          child: MyTextField(
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
                              color: Colors.grey[400],
                            ),
                            child: const Icon(Icons.done, size: 30),
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
                        value: _isChecked2,
                        title: SizedBox(
                          height: 30,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('assets/images/sowki.png')),
                        ),
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked2 = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 125,
                    child: Center(
                      child: MyTextField(
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
                          color: Colors.grey[400],
                        ),
                        child: const Icon(Icons.done, size: 30),
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
                        value: _isChecked3,
                        title: SizedBox(
                          height: 30,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('assets/images/zabki.png')),
                        ),
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked3 = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 125,
                    child: Center(
                      child: MyTextField(
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
                          color: Colors.grey[400],
                        ),
                        child: const Icon(Icons.done, size: 30),
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
