part of 'marks_bloc.dart';

abstract class MarksEvent extends Equatable {
  const MarksEvent();

  @override
  List<Object> get props => [];
}

class MarksButtonPressed extends MarksEvent {
  final studentId;

  MarksButtonPressed({
    required this.studentId,
  });

  List<Object> get props => [studentId];

  @override
  String toString() => 'MarksButtonPressed { studentId: $studentId }';
}

class FinalResultButtonPressed extends MarksEvent {
  final sessionId;
  final studentId;
  final examId;
  FinalResultButtonPressed(
      {required this.sessionId, required this.examId, required this.studentId});
  List<Object> get props => [sessionId, studentId, examId];
  @override
  String toString() =>
      'FinalResultButtonPressed {sessionId : $sessionId, examId : $examId, studentId : $studentId}';
}
