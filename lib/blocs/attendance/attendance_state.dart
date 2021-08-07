part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final content;
  AttendanceLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'AttendanceLoaded { content: $content }';
}

class AttendanceLoadingFailure extends AttendanceState {
  final error;
  AttendanceLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'AttendanceLoadingFailure { error: $error }';
}
