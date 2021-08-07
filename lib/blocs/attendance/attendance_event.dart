part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class AttendanceButtonPressed extends AttendanceEvent {
  final studentId;
  final startDate;
  final endDate;

  AttendanceButtonPressed(
      {@required this.studentId,
      @required this.startDate,
      @required this.endDate});

  List<Object> get props => [studentId, startDate, endDate];

  @override
  String toString() =>
      'AttendanceButtonPressed { studentId: $studentId, startDate: $startDate,endDate : $endDate }';
}
