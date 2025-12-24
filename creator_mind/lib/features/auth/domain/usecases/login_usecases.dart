
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }

  @override
  Future<Either<Failure, User>> callRegister(Map<String, dynamic> params) {
    return repository.register(params);
  }
}

class LoginParams{
  final String email;
  final String password;
  LoginParams(this.email, this.password);
}