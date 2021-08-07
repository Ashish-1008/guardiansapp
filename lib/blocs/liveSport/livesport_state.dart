part of 'livesport_bloc.dart';

abstract class LiveSportState extends Equatable {
  const LiveSportState();

  @override
  List<Object> get props => [];
}

class LiveSportInitial extends LiveSportState {}

class LiveSportLoading extends LiveSportState {}

class LiveSportLoaded extends LiveSportState {
  final content;
  LiveSportLoaded({@required this.content});

  List<Object> get props => [content];
  @override
  String toString() => 'LiveSportLoaded { content: $content }';
}

class LiveSportLoadingFailure extends LiveSportState {
  final error;
  LiveSportLoadingFailure({@required this.error});

  List<Object> get props => [error];
  @override
  String toString() => 'LiveSportLoadingFailure { error: $error }';
}
