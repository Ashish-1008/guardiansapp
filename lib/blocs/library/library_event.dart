part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class LibraryButtonPressed extends LibraryEvent {
  final studentId;
  final dataType;

  LibraryButtonPressed({
    required this.studentId,
    required this.dataType,
  });

  List<Object> get props => [studentId, dataType];

  @override
  String toString() =>
      'LibraryButtonPressed { studentId: $studentId,dataType : $dataType }';
}
