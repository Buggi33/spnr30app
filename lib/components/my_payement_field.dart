import 'package:flutter/material.dart';

class MyPaymentField extends StatelessWidget {
  final String contractNumber;
  final String payment;
  final String excessPayment;

  const MyPaymentField({
    super.key,
    required this.contractNumber,
    required this.payment,
    required this.excessPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
      child: Container(
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
        padding: const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
        height: 50,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      style: TextStyle(color: Colors.grey[700]),
                      contractNumber),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 40),
                  alignment: Alignment.center,
                  child:
                      Text(style: TextStyle(color: Colors.grey[700]), payment),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: Text(
                      style: TextStyle(color: Colors.grey[700]), excessPayment),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
