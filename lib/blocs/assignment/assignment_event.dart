part of 'assignment_bloc.dart';

abstract class AssignmentEvent extends Equatable {
  const AssignmentEvent();

  @override
  List<Object> get props => [];
}

class AssignmentButtonPressed extends AssignmentEvent {
  final studentId;

  AssignmentButtonPressed({this.studentId});
  @override
  List<Object> get props => [studentId];
}
