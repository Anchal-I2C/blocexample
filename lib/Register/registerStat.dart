import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class RegisterStat extends Equatable {
  String? name = "";
  String? email = "";
  String? password = "";
  String? uid = "";

  RegisterStat({this.name,this.email, this.password,this.uid});

  @override
  List<Object?> get props => [name,email, password,uid];

  RegisterStat copyWith({
    String? name,
    String? email,
    String? password,
    String? uid,
  }) {
    return RegisterStat(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid?? this.uid,
    );
  }
}
