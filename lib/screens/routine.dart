import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/routine/routine_bloc.dart';
import 'package:guardiansapp/repositories/routine_repo.dart';

class RoutinePage extends StatelessWidget {
  RoutineRepository _routineRepository = new RoutineRepository();
  RoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
          child: Routine(),
          create: (context) =>
              RoutineBloc(routineRepository: _routineRepository)
                ..add(RoutineButtonPressed(studentId: 1))),
    );
  }
}

class Routine extends StatefulWidget {
  Routine({Key? key}) : super(key: key);

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.PrimaryColor,
        title: Text('Routine'),
      ),
      body: BlocBuilder<RoutineBloc, RoutineState>(builder: (context, state) {
        if (state is RoutineLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RoutineLoaded) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 30,
                dividerThickness: 2,
                columns: [
                  for (var i = 0; i < state.content['headers'].length; i++)
                    DataColumn(
                        label: Expanded(
                            child: Center(
                      child: Text(
                        '${state.content['headers'][i]['data']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                      ),
                    ))),
                ],
                rows: List.generate(state.content['rows'].length, (index) {
                  return DataRow(cells: <DataCell>[
                    for (var i = 0;
                        i < state.content['rows'][index].length;
                        i++)
                      state.content['rows'][index][i]['type'] == 'lunchbreak'
                          ? DataCell(Center(child: Text('Break')))
                          : DataCell(Center(
                              child: Text(
                                  '${state.content['rows'][index][i]['data']}'),
                            ))
                  ]);
                })),
          );
        }
        return Container();
      }),
    );
  }
}
