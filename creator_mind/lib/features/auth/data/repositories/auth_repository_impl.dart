
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/left.dart';
import '../../../../core/utils/right.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password)async {
    try {
      final user = await authRemoteDataSource.login(email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return Left(ServerFailure("Unexpected error"));
    }
  }

  @override
  Future<Either<Failure, User>> register(Map<String, dynamic> data) async{
    try{
      final user = await authRemoteDataSource.register(data);
      return Right(user);
    } on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }catch(e){
      return Left(ServerFailure("Unexpected error"));
    }
  }
}