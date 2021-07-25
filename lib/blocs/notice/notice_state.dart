part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInitial extends NoticeState {}

class NoticeLoading extends NoticeState {}

class NoticeLoadingFailure extends NoticeState {
  final error;
  NoticeLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'NoticeLoadingFailure { error: $error }';
}

class NoticeLoaded extends NoticeState {
  final content;
  NoticeLoaded({@required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'NoticeLoaded { content: $content }';
}
