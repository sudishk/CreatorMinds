
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../data/models/attendence_model.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, void>> requestAttendance(Attendance attendance);
  Stream<List<AttendanceModel>> watchMyAttendance(String studentId, String date);
}