import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/left.dart';
import '../../../../core/utils/right.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendence_repository.dart';
import '../datasources/attendence_romote_db.dart';
import '../models/attendence_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remote;

  AttendanceRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> requestAttendance(
      Attendance attendance) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      await remote.requestAttendance({
        "id": attendance.studentName + id,
        "studentId": attendance.studentId,
        "studentName": attendance.studentName,
        "date": attendance.date,
        "status": "Pending",
        "requestedAt": FieldValue.serverTimestamp(),
      });
      return Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to request attendance"));
    }
  }

  @override
  Stream<List<AttendanceModel>> watchMyAttendance(String studentId, String date) {
    return remote.watchMyAttendance(studentId, date).map((models) {
      return models.map((model) => model).toList();
    });
  }

}
