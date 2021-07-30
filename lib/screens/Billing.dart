import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/Billing/billing_bloc.dart';
import 'package:guardiansapp/repositories/bill_repository.dart';

class Billing extends StatelessWidget {
  BillRepository billRepository = new BillRepository();
  Billing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
          child: BillingBody(),
          create: (context) => BillingBloc(billRepository: billRepository)
            ..add(BillingButtonPressed(studentId: 1))),
    );
  }
}

class BillingBody extends StatefulWidget {
  BillingBody({Key? key}) : super(key: key);

  @override
  _BillingBodyState createState() => _BillingBodyState();
}

class _BillingBodyState extends State<BillingBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingBloc, BillingState>(builder: (context, state) {
      if (state is BillLoading) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Container();
    });
  }
}
