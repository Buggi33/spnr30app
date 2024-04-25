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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//logo
// Image.asset('assets/images/sloneczka.png', height: 150),
                Image.asset(scale: 5, 'assets/images/LOGO_30_5.png'),

                const SizedBox(height: 20),

//welcome title
                const Text(
                  'Witaj w SPNR30!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 26, 64),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

//email field
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                    bottom: 5,
                  ),
                  child: MyTextField(
                    style: TextStyle(color: Colors.blue[800]),
                    maxLines: 1,
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                ),

//pole hasła
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 5,
                    right: 20,
                    bottom: 5,
                  ),
                  child: MyTextField(
                    style: TextStyle(color: Colors.blue[800]),
                    maxLines: 1,
                    controller: passwordController,
                    hintText: 'Hasło',
                    obscureText: true, //ukrywa hasło pod kropkami
                  ),
                ),

                const SizedBox(height: 10),

//zapomniałeś hasła?
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

                const SizedBox(height: 25),

//zaloguj się btn
                MyLogRegButton(
                  text: 'Zaloguj',
                  textColor: const Color.fromARGB(255, 245, 26, 64),
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
                    const Text(
                      'Nie posiadasz konta?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Zarejestruj się!',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 245, 26, 64),
                          color: Color.fromARGB(255, 245, 26, 64),
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
      ),
    );
  }
}
