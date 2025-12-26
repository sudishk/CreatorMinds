
import 'package:creator_mind/features/attendence/attendance_injection.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/auth_injection.dart';

final sl = GetIt.instance;
Future<void> init()async{
  await authInjection();
  await attendanceInjection();
}