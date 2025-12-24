abstract class AuthEvent {

}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final Map<String, dynamic> data;
  RegisterRequested(this.data);
}