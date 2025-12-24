import 'package:bloc/bloc.dart';

import '../../domain/usecases/login_usecases.dart';
import 'login_event.dart';
import 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInit()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(
        LoginParams(event.email, event.password),
      );
      result.fold((l) => emit(LoginError(l.message.toString())), (r) => emit(LoginSuccess(r)),);
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase.callRegister(event.data);
      result.fold((l) => emit(RegisterError(l.message.toString())), (r) => emit(RegisterSuccess(r)),);
    });
  }
}
