part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesButtonPressed extends NotesEvent {
  final studentId;

  NotesButtonPressed({this.studentId});
  @override
  List<Object> get props => [studentId];
}
