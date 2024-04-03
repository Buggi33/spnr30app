import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_log_reg_button.dart';
import 'package:spnr30app/components/my_textfield.dart';
// import 'package:spnr30app/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void logIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try to log in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //wrong email message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                // Image.asset('assets/images/sloneczka.png', height: 150),
                const Icon(
                  Icons.lock,
                  size: 120,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                //witaj spowrotem, tęskniliśmy
                Text(
                  'Witaj w SPNR30!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //pole użytkownika
                MyTextField(
                  maxLines: 1,
                  controller: emailController,
                  hintText: 'Nazwa użytkownika',
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

                //zapomniałeś hasła?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Przypomnij hasło',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //zaloguj się btn
                MyLogRegButton(
                  text: 'Zaloguj',
                  onTap: logIn,
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
                        'Zarejestruj się!',
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
        ));
  }
}
