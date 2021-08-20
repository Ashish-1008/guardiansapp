part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class ApplicationButtonPressed extends ApplicationEvent {
  final studentId;

  ApplicationButtonPressed({this.studentId});
  @override
  List<Object> get props => [studentId];
}

class ApplicationSubjectButtonPressed extends ApplicationEvent {
  ApplicationSubjectButtonPressed();
  @override
  List<Object> get props => [];
}

class SaveApplicationButtonPressed extends ApplicationEvent {
  final data;

  SaveApplicationButtonPressed({this.data});
  @override
  List<Object> get props => [data];
}
