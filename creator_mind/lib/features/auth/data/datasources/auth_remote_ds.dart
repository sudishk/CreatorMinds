
import 'package:creator_mind/features/auth/data/models/user_model.dart';
import 'package:creator_mind/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password );
  Future<UserModel> register(RegisterParams data);
}