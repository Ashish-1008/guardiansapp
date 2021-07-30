part of 'billing_bloc.dart';

abstract class BillingState extends Equatable {
  const BillingState();

  @override
  List<Object> get props => [];
}

class BillingInitial extends BillingState {}

class BillLoading extends BillingState {}

class BillLoaded extends BillingState {
  final content;
  BillLoaded({required this.content}) : assert(content != null);
  List<Object> get props => [content];

  @override
  String toString() => 'BillLoaded { content: $content }';
}

class BillLoadingFailure extends BillingState {
  final error;
  BillLoadingFailure({this.error});
  List<Object> get props => [error];

  @override
  String toString() => 'BillingLoadingFailure { error: $error }';
}
