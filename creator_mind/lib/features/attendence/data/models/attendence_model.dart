import '../../domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required super.id,
    required super.studentId,
    required super.studentName,
    required super.date,
    required super.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> data,) {

    return AttendanceModel(
      id: data["id"],
      studentId: data['studentId'],
      studentName: data['studentName'],
      date: data['date'],
      status: data['status'],
    );
  }

}
