import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String getFormattedDate() {
  final now = DateTime.now();
  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  final year = now.year.toString();
  return '$day/$month/$year'; // 25/12/2025
}

Future<Map<String, dynamic>?> getUser()async{
  var uid = FirebaseAuth.instance.currentUser?.uid;
  var doc =await FirebaseFirestore.instance.collection("creator_minds_users").doc("$uid").get();
  return doc.data();
}