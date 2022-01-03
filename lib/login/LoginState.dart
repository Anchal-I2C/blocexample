import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  String? email = "";
  String? password = "";

  LoginState({this.email, this.password});

  @override
  List<Object?> get props => [email, password];

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
