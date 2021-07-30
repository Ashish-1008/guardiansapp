part of 'exam_bloc.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final content;
  ExamLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => '  ExamLoaded { content: $content }';
}

class ExamLoadingFailure extends ExamState {
  final error;
  ExamLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'ExamLoadingFailure { error: $error }';
}
