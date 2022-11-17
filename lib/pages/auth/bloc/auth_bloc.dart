// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import '../../repoUser.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserAuthRepository _userAuthRepository = UserAuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerification);
    on<SignOutEvent>(_signOut);
    on<GoogleAuthEvent>(_authUser);
  }

  FutureOr<void> _authVerification(event, emit) {
    if (_userAuthRepository.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    await _userAuthRepository.signOutFirebaseUser();
    await _userAuthRepository.signOutGoogleUser();
    emit(SignOutSuccessState());
  }

  FutureOr<void> _authUser(event, emit) async {
    try {
      await _userAuthRepository.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState());
    }
  }
}
