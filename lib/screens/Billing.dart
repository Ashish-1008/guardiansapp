import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/MyColors.dart';
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
  String dropdownValue = 'Baishak';

  prepareToShowBill(response, value) {
    for (var i = 0; i < response.length; i++) {
      if (response[i]['fee_title'].contains(value)) {
        return response[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees'),
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: BlocBuilder<BillingBloc, BillingState>(builder: (context, state) {
        if (state is BillLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is BillLoaded) {
          var resp = prepareToShowBill(state.content, dropdownValue);
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 100, right: 100, bottom: 24, top: 12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      elevation: 16,
                      underline: Container(),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Baishak',
                        'Jesth',
                        'Ashadh',
                        'Shrawan',
                        'Bhadra',
                        'Ashwin',
                        'Kartik',
                        'Mangsir',
                        'Poush',
                        'Magh',
                        'Falgun',
                        'Chaitra',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              resp != null ? Text('kei xa re vai') : Text('Khali raam'),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
