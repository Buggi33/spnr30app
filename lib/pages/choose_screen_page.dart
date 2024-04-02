import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChooseScreenPage extends StatelessWidget {
  const ChooseScreenPage({super.key});

//logout user
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Samorządowe Przedszkole nr 30',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              'Wybierz grupę Twojej pociechy i zaczynamy!',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[100],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/sloneczka.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/sowki.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/zabki.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
