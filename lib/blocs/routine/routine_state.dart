part of 'routine_bloc.dart';

abstract class RoutineState extends Equatable {
  const RoutineState();

  @override
  List<Object> get props => [];
}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineLoaded extends RoutineState {
  final content;
  RoutineLoaded({@required this.content});

  List<Object> get props => [content];
  @override
  String toString() => 'RoutineLoaded { content: $content }';
}

class RoutineLoadingFailure extends RoutineState {
  final error;
  RoutineLoadingFailure({@required this.error});

  List<Object> get props => [error];
  @override
  String toString() => 'RoutineLoadingFailure { error: $error }';
}
