

import 'package:creator_mind/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:creator_mind/features/auth/data/datasources/auth_remote_ds_impl.dart';
import 'package:creator_mind/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:creator_mind/features/auth/domain/repositories/auth_repository.dart';
import 'package:creator_mind/features/auth/domain/usecases/login_usecases.dart';
import 'package:creator_mind/features/auth/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> authInjection()async{
  sl.registerFactory(() => AuthBloc(sl()),);

  sl.registerLazySingleton(() => LoginUseCase(sl()),);

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()),);

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(),);


}