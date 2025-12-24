
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(Map<String, dynamic> data);
}