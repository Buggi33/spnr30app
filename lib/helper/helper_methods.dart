//return a formatted data as a string

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
//Timestamp is the object we retrieve from firebase
//so to display it, lets cover it to a string

  DateTime dateTime = timestamp.toDate();

//get year
  String year = dateTime.year.toString();
//get month
  String month = dateTime.month.toString();
//get day
  String day = dateTime.day.toString();
//get day
  String hour = dateTime.hour.toString();
//get day
  String minute = dateTime.minute.toString();

//final combained date
  String formattedData = '$day/$month/$year $hour:$minute';
  return formattedData;
}
