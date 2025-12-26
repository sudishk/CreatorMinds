import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/attendence_romote_db.dart';
import 'data/datasources/attendence_remote_db_impl.dart';
import 'data/repositories/attendence_repository_impl.dart';
import 'domain/repositories/attendence_repository.dart';
import 'domain/usecase/attendence_usecase.dart';
import 'presentation/bloc/attendance_bloc.dart';

final sl = GetIt.instance;

Future<void> attendanceInjection() async {

  sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton<AttendanceRemoteDataSource>(
        () => AttendanceRemoteDataSourceImpl(sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<AttendanceRepository>(
        () => AttendanceRepositoryImpl(sl<AttendanceRemoteDataSource>()),
  );

  sl.registerLazySingleton<RequestAttendanceUseCase>(
        () => RequestAttendanceUseCase(sl<AttendanceRepository>()),
  );

  sl.registerLazySingleton<WatchAttendanceUseCase>(
        () => WatchAttendanceUseCase(sl<AttendanceRepository>()),
  );

  sl.registerFactory<AttendanceBloc>(
        () => AttendanceBloc(
      sl<RequestAttendanceUseCase>(),
      sl<WatchAttendanceUseCase>(),
    ),
  );
}
