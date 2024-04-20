import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_payement_field.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final _searchController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  String searchResults = '';
  final FocusNode _textFocusNode = FocusNode();

  final Stream<QuerySnapshot> contractsStream = FirebaseFirestore.instance
      .collection('Contracts')
      .orderBy('ID', descending: false)
      .snapshots();

  void _handleTap() {
    if (_textFocusNode.hasFocus) {
      _textFocusNode.unfocus(); // Jeśli pole jest zaznaczone, odznacz je
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          foregroundColor: Colors.grey[700],
          centerTitle: true,
          title: const Text('P Ł A T N O Ś C I'),
          elevation: 6,
          shadowColor: Colors.black,
          backgroundColor: Colors.grey[300],
          actions: [
            (currentUser.email == 'admin@admin.com')
                ? IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/admin_payments_page'),
                    icon: const Icon(Icons.admin_panel_settings_outlined))
                : const SizedBox(),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 4),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
                color: Colors.grey[350],
              ),
              padding:
                  const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      style: TextStyle(color: Colors.grey[700]), 'Numer umowy'),
                  Text(
                      style: TextStyle(color: Colors.grey[700]),
                      'Kwota do zapłaty'),
                  Text(style: TextStyle(color: Colors.grey[700]), 'Nadpłata'),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: contractsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Wystąpił błąd: $snapshot.error'),
                    );
                  }
                  final List<QueryDocumentSnapshot> contracts =
                      snapshot.data!.docs;

                  List<QueryDocumentSnapshot> filteredContracts =
                      contracts.where((contract) {
                    final contractNumber = contract.id.toLowerCase();
                    return contractNumber.contains(searchResults.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredContracts.length,
                    itemBuilder: (_, index) {
                      final contract = filteredContracts[index];
                      return MyPaymentField(
                        contractNumber: contract.id,
                        payment: contract['Payment'],
                        excessPayment: contract['ExcessPayment'],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 50, top: 10, right: 50, bottom: 10),
                  child: TextField(
                    focusNode: _textFocusNode,
                    onChanged: (String value) {
                      setState(() {
                        searchResults = value;
                      });
                    },
                    controller: _searchController,
                    style: TextStyle(color: Colors.grey[700]),
                    decoration: InputDecoration(
                      hintText: 'Wyszukaj..',
                      fillColor: Colors.grey[400],
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(
                          color: Colors.white, Icons.search), //padding inside
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none, //none underline
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                      filled: true,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
