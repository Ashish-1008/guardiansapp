import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/attendance/attendance_bloc.dart';

import 'package:guardiansapp/repositories/attendance_repository.dart';
import 'package:guardiansapp/screens/Homepage.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  AttendanceRepository attendanceRepository = new AttendanceRepository();
  AttendanceBloc? _attendanceBloc;
  @override
  void initState() {
    _attendanceBloc =
        AttendanceBloc(attendanceRepository: attendanceRepository);
    super.initState();
  }

  DateTime selectedDateInitial = DateTime.now();
  DateTime selectedDateFinal = DateTime.now();
  _selectDate({required bool fromStart}) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          fromStart ? selectedDateInitial : selectedDateFinal, // Refer step 1
      firstDate: DateTime(int.parse(formatted.split('-')[0])),
      lastDate: DateTime(int.parse(formatted.split('-')[0]), 12, 31),
    );
    if (picked != null &&
        (picked != selectedDateInitial || picked != selectedDateFinal))
      setState(() {
        if (fromStart) {
          selectedDateInitial = picked;
        } else {
          selectedDateFinal = picked;
        }
      });
  }

  var val;

  DataCell showAttendance(date, attendance, id) {
    var finalValue;

    attendance[id.toString()].forEach((k, v) {
      if (k.toString() == date) {
        finalValue = v;
      }
    });
    if (finalValue == '1') {
      return DataCell(Text(
        'P',
        style: TextStyle(color: Colors.green),
      ));
    }
    if (finalValue == '0') {
      return DataCell(Text(
        'A',
        style: TextStyle(color: Colors.red),
      ));
    } else {
      return DataCell(Text(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
          backgroundColor: MyColor.PrimaryColor,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Select Date Range',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectDate(fromStart: true);
                            },
                            child: Column(
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$selectedDateInitial.toLocal()'
                                      .split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(fromStart: false);
                            },
                            child: Column(
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$selectedDateFinal.toLocal()'.split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: MaterialButton(
                        height: 55,
                        minWidth: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search Attendance",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        onPressed: () {
                          final DateFormat serverFormater =
                              DateFormat('yyyy-MM-dd');
                          final formatedInitial =
                              serverFormater.format(selectedDateInitial);
                          final formatedFinal =
                              serverFormater.format(selectedDateFinal);
                          _attendanceBloc!.add(AttendanceButtonPressed(
                              studentId: 1,
                              startDate: formatedInitial,
                              endDate: formatedFinal));
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<AttendanceBloc, AttendanceState>(
                bloc: _attendanceBloc,
                builder: (context, state) {
                  if (state is AttendanceLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AttendanceLoaded) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10),
                      child: DataTable(
                        columnSpacing: 15,
                        columns: [
                          DataColumn(
                            label: Text('Roll'),
                          ),
                          DataColumn(
                              label: Row(children: [
                            Text('Name'),
                            Icon(
                              Icons.arrow_downward,
                              size: 15,
                            ),
                            Text('Days'),
                            Icon(
                              Icons.arrow_forward,
                              size: 15,
                            ),
                          ])),
                          for (var i = 0;
                              i < state.content['dates'].length;
                              i++)
                            DataColumn(
                                label: Text('${state.content['dates'][i]}'
                                    .split('-')[2])),
                        ],
                        rows: List.generate(state.content['students'].length,
                            (index) {
                          return DataRow(cells: <DataCell>[
                            DataCell(
                              Text(
                                  '${state.content['students'][index]['student_roll_number']}'),
                            ),
                            DataCell(
                              Text(
                                  '${state.content['students'][index]['name']}'),
                            ),
                            for (var i = 0;
                                i < state.content['dates'].length;
                                i++)
                              showAttendance(
                                  state.content['dates'][i],
                                  state.content['attendances'],
                                  state.content['students'][0]['id'])
                            // state.content['attendances']['1'].keys
                            //         .contains(state.content['dates'][i])
                            //     ? state.content['attendances']['1'].values
                            //             .contains('1')
                            //         ? DataCell(Text(
                            //             'P',
                            //             style: TextStyle(color: Colors.green),
                            //           ))
                            //         : DataCell(Text(
                            //             'A',
                            //             style: TextStyle(color: Colors.red),
                            //           ))
                            //     : DataCell(Text('')),
                          ]);
                        }),
                      ),
                    );
                  }
                  return Container();
                })
          ],
        ));
  }
}
