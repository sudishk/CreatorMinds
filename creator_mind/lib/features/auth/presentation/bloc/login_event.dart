import '../../domain/usecases/register_usecase.dart';

abstract class AuthEvent {

}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final RegisterParams data;
  RegisterRequested(this.data);
}