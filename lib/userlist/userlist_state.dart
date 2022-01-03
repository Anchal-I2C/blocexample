import 'package:equatable/equatable.dart';

abstract class UserlistState extends Equatable {
}

class InitialState extends UserlistState {
  @override
  List<Object> get props => [];
}
class LoadingState extends UserlistState {
  @override
  List<Object> get props => [];
}
class LoadedState extends UserlistState {
  LoadedState(this.data);

  final List data;

  @override
  List<Object> get props => [data];
}
class ErrorState extends UserlistState {
  @override
  List<Object> get props => [];
}

