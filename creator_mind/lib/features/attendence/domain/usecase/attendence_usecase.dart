import 'package:creator_mind/core/usecases/usecase.dart';

import '../../data/models/attendence_model.dart';
import '../entities/attendance.dart';
import '../repositories/attendence_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';

class RequestAttendanceUseCase extends UseCase<void, Attendance> {

  final AttendanceRepository repository;
  RequestAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Attendance attendance) {
    return repository.requestAttendance(attendance);
  }
}

class WatchAttendanceUseCase {

  final AttendanceRepository repository;
  WatchAttendanceUseCase(this.repository);

  Stream<List<AttendanceModel>> call(String studentId, String date) {
    return repository.watchMyAttendance(studentId, date);
  }
}