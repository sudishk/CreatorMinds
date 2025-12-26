import '../../domain/entities/attendance.dart';

abstract class AttendanceEvent {}

class RequestAttendanceEvent extends AttendanceEvent {
  final Attendance attendance;
  RequestAttendanceEvent(this.attendance);
}

class WatchMyAttendanceEvent extends AttendanceEvent {
  final String studentId;
  final String date;
  WatchMyAttendanceEvent(this.studentId, this.date);
}
