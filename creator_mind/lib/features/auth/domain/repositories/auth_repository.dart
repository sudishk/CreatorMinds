
import 'package:creator_mind/features/auth/domain/usecases/register_usecase.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(RegisterParams data);
}