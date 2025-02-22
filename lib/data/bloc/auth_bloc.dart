import 'package:aplle_shop_pj/data/bloc/auth_event.dart';
import 'package:aplle_shop_pj/data/bloc/auth_state.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/authentication_repasitory.dart';
import 'package:aplle_shop_pj/di/di.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepasitory repository = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthStateLoading());
        var response = await repository.login(event.username, event.password);
        emit(AuthResponseState(response));
      },
    );
    on<AuthRegisterRequest>(
      (event, emit) async {
        emit(AuthStateLoading());
        var response = await repository.register(
            event.username, event.password, event.passwordConfirm);
        emit(AuthResponseState(response));
      },
    );
  }
}
