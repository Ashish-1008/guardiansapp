import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/bill_repository.dart';

import '../../helper_function.dart';

part 'billing_event.dart';
part 'billing_state.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  BillingBloc({required this.billRepository}) : super(BillingInitial());
  BillRepository billRepository = new BillRepository();

  @override
  Stream<BillingState> mapEventToState(
    BillingEvent event,
  ) async* {
    if (event is BillingButtonPressed) {
      yield BillLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await billRepository.getBill(
              token: token, studentId: event.studentId);

          yield BillLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield BillLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield BillLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
