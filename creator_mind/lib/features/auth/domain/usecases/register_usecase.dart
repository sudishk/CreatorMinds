import 'dart:core';

import 'package:creator_mind/core/usecases/usecase.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';



class RegisterUserUseCase extends UseCase<User, RegisterParams> {

  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(
      RegisterParams params,
      ) {
    return repository.register(params);
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String className;
  final String gender;
  final String email;
  final String password;
  final String phone;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.className,
    required this.gender,
    required this.email,
    required this.password,
    required this.phone,
  });
}
