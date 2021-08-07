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
          print(resp);
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
              resp != null
                  ? Container(
                      child: Column(
                        children: [
                          Text(
                              'Siddhartha Shishu Sadan Higher Secondary School'),
                          SizedBox(height: 10),
                          Text('Biratnagar-6,Morang,Nepal'),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bill No. : 12345'),
                                Text('Date : ${resp['paid_date']}')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Fee Title : ${resp['fee_title']}'),
                                Text(
                                    'Fee Description : ${resp['fee_description']}')
                              ],
                            ),
                          ),
                          DataTable(
                              columnSpacing: 30,
                              columns: const <DataColumn>[
                                DataColumn(label: Text('S.N.')),
                                DataColumn(label: Text('Particulars')),
                                DataColumn(label: Text('Total'))
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('1')),
                                  DataCell(Text('Admission Fee Yearly')),
                                  DataCell(Text('1'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('2')),
                                  DataCell(Text('Monthly Fee Yearly')),
                                  DataCell(Text('1'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('3')),
                                  DataCell(Text('Library Service Fee')),
                                  DataCell(Text('1'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('4')),
                                  DataCell(Text('Registration Form Fee')),
                                  DataCell(Text('1'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('5')),
                                  DataCell(Text('Examination Form Fee')),
                                  DataCell(Text('1'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('6')),
                                  DataCell(Text('Bus Charge')),
                                  DataCell(resp['payment_detail']?['bus'] !=
                                          null
                                      ? Text('${resp['payment_detail']['bus']}')
                                      : Text('-'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('7')),
                                  DataCell(Text('Fine Amount')),
                                  DataCell(Text('${resp['fine_amount']}'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('8')),
                                  DataCell(Text('Discount Amount')),
                                  DataCell(resp['discount_amount'] != null
                                      ? Text('${resp['discount_amount']}')
                                      : Text('-'))
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('9')),
                                  DataCell(Text('Grand Total')),
                                  DataCell(Text('${resp['total_amount']}'))
                                ]),
                              ])
                        ],
                      ),
                    )
                  : Positioned(
                      child: Container(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.red.shade300,
                            child: Text(
                              'Sorry!! No Bill available for searched month',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
