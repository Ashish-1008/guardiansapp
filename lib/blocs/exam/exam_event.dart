part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object> get props => [];
}

class SearchExamButtonPressed extends ExamEvent {
  final sessionId;

  SearchExamButtonPressed({
    required this.sessionId,
  });

  List<Object> get props => [sessionId];

  @override
  String toString() => 'SearchExamButtonPressed { studentId: $sessionId }';
}
