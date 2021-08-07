part of 'livesport_bloc.dart';

abstract class LiveSportEvent extends Equatable {
  const LiveSportEvent();

  @override
  List<Object> get props => [];
}

class LiveSportButtonPressed extends LiveSportEvent {
  LiveSportButtonPressed();
  @override
  List<Object> get props => [];
}
