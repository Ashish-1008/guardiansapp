part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final phone;
  final password;

  LoginButtonPressed({
    @required this.phone,
    @required this.password,
  });

  List<Object> get props => [phone, password];

  @override
  String toString() =>
      'LoginButtonPressed { phone: $phone, password: $password }';
}

class LogoutButtonPressed extends LoginEvent {}

class LoginStart extends LoginEvent {}
