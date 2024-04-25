import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void _launchPhone(String phoneNumber) async {
    String url = "tel:$phoneNumber";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String emailAddress) async {
    String url = "mailto:$emailAddress";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 245, 26, 64),
        title: const Text("K O N T A K T"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 39, 73),
        shadowColor: Colors.black,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 51),
                child: Text(
                    style: TextStyle(color: Colors.grey),
                    'Kliknij odpowiedni numer lub email, aby wybrać.'),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
              padding:
                  const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
              child: Column(
                children: [
                  const Text(
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      'P R Z E D S Z K O L E'),
                  const Text(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      'DO ZGŁASZANIA NIEOBECNOŚCI DZIECKA'),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _launchPhone("508 872 732"),
                    child: const Text(
                      '508 872 732',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 245, 26, 64),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
              padding:
                  const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
              child: Column(
                children: [
                  const Text(
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      'S E K R E T A R I A T  G Ł Ó W N Y'),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _launchPhone("12 415 56 66"),
                    child: const Text(
                      '12 415 56 66',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 245, 26, 64),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _launchPhone("508 872 762"),
                    child: const Text(
                      '508 872 762',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 245, 26, 64),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
              padding:
                  const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
              child: Column(
                children: [
                  const Text(
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      'I N T E N D E N T'),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _launchPhone("793 864 377"),
                    child: const Text(
                      '793 864 377',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 245, 26, 64),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
              padding:
                  const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
              child: Column(
                children: [
                  const Text(
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      'E - M A I L'),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _launchEmail("zsp16@mjo.krakow.pl"),
                    child: const Text(
                      'zsp16@mjo.krakow.pl',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 245, 26, 64),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
