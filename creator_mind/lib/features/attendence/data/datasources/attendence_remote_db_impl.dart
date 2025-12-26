import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_mind/features/attendence/data/models/attendence_model.dart';

import 'attendence_romote_db.dart';

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {

  final FirebaseFirestore firestore;

  AttendanceRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> requestAttendance(Map<String, dynamic> data) async {
    await firestore.collection("creator_minds_attendence").doc(data["id"]).set(data);
  }

  @override
  Stream<List<AttendanceModel>> watchMyAttendance(String studentId, String date) {
    return firestore
        .collection('creator_minds_attendence')
        .where('studentId', isEqualTo: studentId)
        .where('date', isEqualTo: date)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AttendanceModel.fromJson(doc.data()))
          .toList();
    });
  }
}
