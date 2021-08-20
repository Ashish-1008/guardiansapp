part of 'routine_bloc.dart';

abstract class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object> get props => [];
}

class RoutineButtonPressed extends RoutineEvent {
  final studentId;

  RoutineButtonPressed({this.studentId});
  @override
  List<Object> get props => [studentId];
}
