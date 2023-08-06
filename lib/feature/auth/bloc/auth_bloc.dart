import 'package:fit_bits/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthStatus> {
  final AuthRepository userRepository;

  AuthCubit({required this.userRepository}) : super(AuthStatus.initial);

  void checkAuthenticationStatus() {
    if (userRepository.isAuthenticated()) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }
  }

  void signIn({required String email, required String password}) async {
    emit(AuthStatus.initial);
    try {
      await userRepository.signIn(email: email, password: password);
      checkAuthenticationStatus();
    } catch (e) {
      emit(AuthStatus.unauthenticated);
    }
  }

  void signOut() async {
    await userRepository.signOut();
    checkAuthenticationStatus();
  }
}
