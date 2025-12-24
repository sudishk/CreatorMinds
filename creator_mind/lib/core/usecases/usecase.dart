
import '../error/failure.dart';
import '../utils/either.dart';

abstract class UseCase<Type, Params>{
  Future <Either<Failure ,Type>> call(Params params);
  Future <Either<Failure ,Type>> callRegister(Map<String, dynamic> params);
}