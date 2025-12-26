import '../models/attendence_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<void> requestAttendance(Map<String, dynamic> data);
  Stream<List<AttendanceModel>> watchMyAttendance(String studentId, String date);
}