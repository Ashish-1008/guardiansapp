part of 'master_bloc.dart';

abstract class MasterEvent extends Equatable {
  const MasterEvent();

  @override
  List<Object> get props => [];
}

class Appstarted extends MasterEvent {}
