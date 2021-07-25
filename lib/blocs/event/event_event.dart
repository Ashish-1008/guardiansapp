part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventButtonPressed extends EventEvent {
  final studentId;

  EventButtonPressed({
    @required this.studentId,
  });

  List<Object> get props => [studentId];

  @override
  String toString() => 'EventButtonPressed { phone: $studentId }';
}

class EventDescriptionButtonPressed extends EventEvent {}
