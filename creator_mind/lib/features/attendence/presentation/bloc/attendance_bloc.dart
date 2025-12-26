import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/attendence_usecase.dart';
import '../../domain/entities/attendance.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc
    extends Bloc<AttendanceEvent, AttendanceState> {

  final RequestAttendanceUseCase requestAttendanceUseCase;
  final WatchAttendanceUseCase watchAttendanceStatusUseCase;

  AttendanceBloc(this.requestAttendanceUseCase, this.watchAttendanceStatusUseCase) : super(AttendanceInitial()) {

    on<RequestAttendanceEvent>((event, emit) async {
      emit(AttendanceLoading());

      final result = await requestAttendanceUseCase(event.attendance);

      result.fold(
            (failure) {
          emit(AttendanceError(failure.message));
        },
            (_) {
          emit(
            AttendanceRequestSuccess(
              "Attendance request sent",
            ),
          );
        },
      );
    });

    on<WatchMyAttendanceEvent>((event, emit) async {
      emit(AttendanceLoading());

      await emit.forEach<List<Attendance>>(
        watchAttendanceStatusUseCase.call(event.studentId, event.date,),
        onData: (list) {
          return AttendanceLoaded(list);
        },
        onError: (_, __) {
          return AttendanceError(
            "Failed to load attendance status",
          );
        },
      );
    });
  }
}



