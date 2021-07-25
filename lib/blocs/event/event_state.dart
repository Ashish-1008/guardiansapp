part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoadingFailure extends EventState {
  final error;
  EventLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'EventLoadingFailure { error: $error }';
}

class EventLoaded extends EventState {
  final content;
  EventLoaded({@required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'EventLoaded { content: $content }';
}
