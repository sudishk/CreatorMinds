import '../../domain/entities/attendance.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceRequestSuccess extends AttendanceState {
  final String message;
  AttendanceRequestSuccess(this.message);
}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> list;
  AttendanceLoaded(this.list);
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}
