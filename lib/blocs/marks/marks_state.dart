part of 'marks_bloc.dart';

abstract class MarksState extends Equatable {
  const MarksState();

  @override
  List<Object> get props => [];
}

class MarksInitial extends MarksState {}

class SessionLoading extends MarksState {}

class SessionLoaded extends MarksState {
  final content;
  SessionLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'SessionLoaded { content: $content }';
}

class SessionLoadingFailure extends MarksState {
  final error;
  SessionLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'SessionLoadingFailure { error: $error }';
}

class ResultLoading extends MarksState {}

class ResultLoaded extends MarksState {
  final content;
  ResultLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => '  ResultLoaded { content: $content }';
}

class ResultLoadingFailure extends MarksState {
  final error;
  ResultLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'ResultLoadingFailure { error: $error }';
}
