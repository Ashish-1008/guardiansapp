part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object> get props => [];
}

class NoticeButtonPressed extends NoticeEvent {
  final int studentId;

  NoticeButtonPressed({
    required this.studentId,
  });

  List<Object> get props => [studentId];

  @override
  String toString() => 'NoticeButtonPressed { student_id: $studentId }';
}
