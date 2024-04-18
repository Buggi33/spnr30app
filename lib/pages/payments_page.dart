import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spnr30app/components/my_payement_field.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

final currentUser = FirebaseAuth.instance.currentUser!;
final Stream<QuerySnapshot> contractsStream = FirebaseFirestore.instance
    .collection('Contracts')
    .orderBy('ID', descending: false)
    .snapshots();

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
              color: Colors.grey[300],
            ),
            padding:
                const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(style: TextStyle(color: Colors.grey[700]), 'Numer umowy'),
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
                return ListView.builder(
                  itemCount: contracts.length,
                  itemBuilder: (_, index) {
                    final contract = contracts[index];
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
        ],
      ),
    );
  }
}
