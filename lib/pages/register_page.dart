import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/helper/helper_show_dialog.dart';
import '../components/my_log_reg_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//text editing controller

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final userNameController = TextEditingController();
  final kidNameController = TextEditingController();

//sign user in method
  void signIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
//make sure passwords match
    if (passwordController.text != confirmPwdController.text) {
      //pop loading circle
      Navigator.pop(context);
//show error to user
      displayMessageToUser("Hasło nie jest takie same", context);
      return;
    }
//try creating the user
    try {
//create the user
      UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

//create a user document and collect them in firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'kidname': kidNameController.text,
      });
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //display error message to the user
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//logo
// Image.asset('assets/images/sloneczka.png', height: 150),
                  const Icon(size: 120, color: Colors.blue, Icons.person),

                  const SizedBox(height: 20),

//Załóż konto
                  Text(
                    'Wypełnij poniższe pola!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

//imię i nazwisko
                  MyTextField(
                    maxLines: 1,
                    controller: userNameController,
                    hintText: 'Imie i nazwisko',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

//imię dziecka
                  MyTextField(
                    maxLines: 1,
                    controller: kidNameController,
                    hintText: 'Imię dziecka',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

//pole email
                  MyTextField(
                    maxLines: 1,
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

//pole hasła
                  MyTextField(
                    maxLines: 1,
                    controller: passwordController,
                    hintText: 'Hasło',
                    obscureText: true, //ukrywa hasło pod kropkami
                  ),

                  const SizedBox(height: 10),

//pole hasła
                  MyTextField(
                    maxLines: 1,
                    controller: confirmPwdController,
                    hintText: 'Potwierdź hasło',
                    obscureText: true, //ukrywa hasło pod kropkami
                  ),

                  const SizedBox(height: 10),

                  // //zapomniałeś hasła?
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         'Przypomnij hasło',
                  //         style: TextStyle(color: Colors.grey[600]),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 25),

//zaloguj się btn
                  MyLogRegButton(
                    text: 'Zarejestruj',
                    onTap: signIn,
                  ),

                  const SizedBox(height: 40),

                  // //lub zaloguj się przez
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 0.5,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: Text(
                  //           'lub zaloguj się przez',
                  //           style: TextStyle(
                  //             color: Colors.grey[700],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 0.5,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 40),

                  // //google + apple sing in btn
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     //google
                  //     SquareTile(imagePath: 'assets/images/Google_Icon.png'),

                  //     SizedBox(width: 10),
                  //     //apple
                  //     SquareTile(imagePath: 'assets/images/Apple_Icon.png')
                  //   ],
                  // ),

                  // const SizedBox(height: 40),

//zarejestruj się
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Załóż konto!',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Zaloguj się!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
