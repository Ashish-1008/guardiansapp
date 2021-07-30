part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final content;
  LibraryLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'LibraryLoaded { content: $content }';
}

class LibraryLoadingFailure extends LibraryState {
  final error;
  LibraryLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'LibraryLoadingFailure { error: $error }';
}
