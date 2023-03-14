class LoginEvent {}

class LoginLoadingEvent extends LoginEvent {}

class LoginPressEvent extends LoginEvent {
  final String email;
  final String password;
  final String diviceToken;

  LoginPressEvent(
    this.email,
    this.password,
    this.diviceToken,
  );
}

class LoginErrorEvent extends LoginEvent {
  final String erroemessage;

  LoginErrorEvent(this.erroemessage);
}
