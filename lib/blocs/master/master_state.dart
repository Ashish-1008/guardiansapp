part of 'master_bloc.dart';

abstract class MasterState extends Equatable {
  const MasterState();

  @override
  List<Object> get props => [];
}

class MasterInitial extends MasterState {}

class MasterLoading extends MasterState {}

class MasterLoaded extends MasterState {
  bool loggedIn;
  MasterLoaded({required this.loggedIn});
  List<Object> get props => [loggedIn];

  @override
  String toString() => 'MasterLoaded{loggedIn : $loggedIn}';
}
