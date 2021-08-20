part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final content;
  NotesLoaded({@required this.content});

  List<Object> get props => [content];
  @override
  String toString() => 'NotesLoaded { content: $content }';
}

class NotesLoadingFailure extends NotesState {
  final error;
  NotesLoadingFailure({@required this.error});

  List<Object> get props => [error];
  @override
  String toString() => 'NotesLoadingFailure { error: $error }';
}
