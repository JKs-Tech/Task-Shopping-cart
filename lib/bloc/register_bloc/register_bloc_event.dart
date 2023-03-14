import 'dart:io';

class RegisterEvent {}

class RegisterPressEvent extends RegisterEvent {
  final String fristName;
  final String surName;
  final String email;
  final String password;
  final File? file;

  RegisterPressEvent(
      this.fristName, this.surName, this.email, this.password, this.file);
}
