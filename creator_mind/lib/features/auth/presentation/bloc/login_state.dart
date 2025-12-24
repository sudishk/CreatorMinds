import '../../domain/entities/user.dart';

abstract class AuthState {

}
class AuthInit extends AuthState{

}

class AuthLoading extends AuthState{

}
class LoginSuccess extends AuthState{
  final User user;
  LoginSuccess(this.user);
}

class LoginError extends AuthState{
  final String message;
  LoginError(this.message);
}

class RegisterSuccess extends AuthState{
  final User user;
  RegisterSuccess(this.user);
}
class RegisterError extends AuthState{
  final String message;
  RegisterError(this.message);
}

