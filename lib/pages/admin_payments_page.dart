import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spnr30app/components/my_adm_textfield.dart';
import 'package:spnr30app/components/my_payement_field.dart';

class AdminPaymentsPage extends StatefulWidget {
  const AdminPaymentsPage({super.key});

  @override
  State<AdminPaymentsPage> createState() => _AdminPaymentsPageState();
}

class _AdminPaymentsPageState extends State<AdminPaymentsPage> {
  final _contractController = TextEditingController();
  final _paymentController = TextEditingController();
  final _excessPaymentController = TextEditingController();

  void addContract() async {
    final int fragment = int.parse(_contractController.text.substring(8));
    if (_contractController.text.isNotEmpty &&
        _paymentController.text.isNotEmpty &&
        _excessPaymentController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('Contracts')
            .doc(_contractController.text)
            .set(
          {
            'ID': fragment,
            'Payment': _paymentController.text,
            'ExcessPayment': _excessPaymentController.text,
          },
        );
      } on FirebaseException catch (e) {
        print(e);
      }
      _paymentController.clear();
    }
  }

  final Stream<QuerySnapshot> contractsStream = FirebaseFirestore.instance
      .collection('Contracts')
      .orderBy('ID', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ADM ADD PAYMENTS'),
        elevation: 12,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  MyAdmTextfield(
                    hintText: 'Podaj numer umowy..',
                    controller: _contractController,
                  ),
                  const SizedBox(height: 5),
                  MyAdmTextfield(
                    hintText: 'Podaj kwotę do zapłaty..',
                    controller: _paymentController,
                  ),
                  const SizedBox(height: 5),
                  MyAdmTextfield(
                    hintText: 'Podaj kwotę nadpłaty..',
                    controller: _excessPaymentController,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: addContract,
                    child: const Text(
                        style: TextStyle(color: Colors.black), 'ADD'),
                  ),
                ],
              ),
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
