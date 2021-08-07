part of 'assignment_bloc.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final content;
  AssignmentLoaded({@required this.content});

  List<Object> get props => [content];
  @override
  String toString() => 'AssignmentLoaded { content: $content }';
}

class AssignmentLoadingFailure extends AssignmentState {
  final error;
  AssignmentLoadingFailure({@required this.error});

  List<Object> get props => [error];
  @override
  String toString() => 'AssignmentLoadingFailure { error: $error }';
}
