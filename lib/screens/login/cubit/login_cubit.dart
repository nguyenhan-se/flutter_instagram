import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/failure_model.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void loginWithCredentials() async {
    if (!state.isFormValid || state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.loginInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (error) {
      emit(state.copyWith(status: LoginStatus.error, failure: error));
    }
  }
}
