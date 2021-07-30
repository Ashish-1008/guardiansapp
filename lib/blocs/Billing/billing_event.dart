part of 'billing_bloc.dart';

abstract class BillingEvent extends Equatable {
  const BillingEvent();

  @override
  List<Object> get props => [];
}

class BillingButtonPressed extends BillingEvent {
  final studentId;

  BillingButtonPressed({
    required this.studentId,
  });

  List<Object> get props => [studentId];

  @override
  String toString() => 'BillingButtonPressed { studentId: $studentId }';
}
