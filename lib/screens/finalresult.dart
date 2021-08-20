import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/marks/marks_bloc.dart';
import 'package:guardiansapp/repositories/marks_repository.dart';
import 'package:guardiansapp/screens/Homepage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FinalResult extends StatelessWidget {
  final studentId;
  final sessionId;
  final examId;
  final MarksRepository marksRepository = new MarksRepository();
  FinalResult(
      {Key? key,
      required this.studentId,
      required this.examId,
      required this.sessionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            child: ResultPage(),
            create: (context) => MarksBloc(marksRepository: marksRepository)
              ..add(FinalResultButtonPressed(
                  sessionId: sessionId,
                  examId: examId,
                  studentId: studentId))));
  }
}

class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

List<Marks> _marks = <Marks>[];

double all_obt_total = 0.0;
double all_fm_total = 0.0;
String percentage = "_";
bool _isFail = false;
_prepareMarks(marks) {
  _marks = [];
  all_obt_total = 0.0;
  all_fm_total = 0.0;
  for (var i = 0; i < marks.length; i++) {
    if (!_isFail) {
      _isFail = marks[i]["th_obt"] == 'A'
          ? true
          : ((double.parse(marks[i]["th_obt"]) <
                      double.parse(marks[i]["th_pm"])) ||
                  ((marks[i]["pr_obt"] != null
                          ? double.parse(marks[i]["pr_obt"])
                          : double.parse('0')) <
                      double.parse(marks[i]?["pr_pm"]))
              ? true
              : false);
    }
    var obtained_total = 0.0;
    all_fm_total = all_fm_total +
        (marks[i]["th_obt"] == 'A'
            ? 0.0
            : (marks[i]["pr_fm"] == 0
                ? double.parse(marks[i]["th_fm"])
                : (double.parse(marks[i]["th_fm"]) +
                    double.parse(marks[i]?["pr_fm"]))));
    obtained_total = marks[i]["th_obt"] == 'A'
        ? 99999.0
        : (marks[i]["pr_fm"] == 0
            ? double.parse(marks[i]["th_obt"])
            : (double.parse(marks[i]["th_obt"]) +
                (marks[i]["pr_obt"] != null
                    ? double.parse(marks[i]["pr_obt"])
                    : double.parse('0'))));
    all_obt_total =
        all_obt_total + (obtained_total == 99999.0 ? 0.0 : obtained_total);
    _marks.add(Marks(
        name: "${marks[i]["subject_name"]}",
        th_fm: "${marks[i]["th_fm"]}",
        th_pm: "${marks[i]["th_pm"]}",
        pr_fm: "${marks[i]["pr_fm"]}",
        pr_pm: "${marks[i]["pr_pm"]}",
        th_obt: "${marks[i]["th_obt"]}",
        pr_obt: marks[i]["pr_obt"] != null ? "${marks[i]["pr_obt"]}" : null,
        total: (obtained_total == 99999.0 ? "A" : "$obtained_total")));
  }
  if (!_isFail) {
    percentage =
        ((all_obt_total / all_fm_total) * 100).toStringAsFixed(2) + " %";
  }
}

class _ResultPageState extends State<ResultPage> {
  late MarksDataSource _studentMarksSource;

  void dispose() {
    super.dispose();
    _marks = [];
    _isFail = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: BlocBuilder<MarksBloc, MarksState>(builder: (context, state) {
        if (state is ResultLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SessionLoadingFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${state.error['message']}"),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    Get.off(HomePage(
                      fromLogin: false,
                    ));
                  },
                  child: Text(
                    'Go Back',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          );
        }
        if (state is ResultLoaded) {
          _prepareMarks(state.content["marks"]);
          _studentMarksSource = MarksDataSource(marksData: _marks);
          print('all fm totoal' + all_fm_total.toString());
          print('all fm totoal' + all_obt_total.toString());

          return Container(
            color: MyColor.PaleWhite,
            child: SingleChildScrollView(
              child: Container(
                height: 750,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColor.White,
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       maxRadius: 30,
                    //       backgroundImage: state.content['result']
                    //                   ['exam_name'] ==
                    //               null
                    //           ? AssetImage(
                    //               'asset/images/image_placeholder.jpg')
                    //           : NetworkImage(
                    //               "${state.content['result']['image']}"),
                    //     ),
                    //     SizedBox(
                    //       width: 30,
                    //     ),
                    //     Flexible(
                    //       child: Text(
                    //         "${state.content['result']['exam_name']}",
                    //         style: TextStyle(
                    //             fontSize: 18, fontWeight: FontWeight.bold),
                    //         overflow: TextOverflow.ellipsis,
                    //         maxLines: 2,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //   child: Center(
                    //     child: Text(
                    //       "${state.content['result']['exam_year']} B.S.",
                    //       style:
                    //           TextStyle(fontSize: 16, color: Colors.grey[700]),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         "Name: ${state.content['result']['student_name']}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Container(),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.only(right: 20),
                    //       child: Text(
                    //         "Class: ${state.content['result']['class']}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         "Roll No: ${state.content["result"]["roll_num"]}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Container(),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.only(right: 20),
                    //       child: Text(
                    //         "Section: " +
                    //             (state.content["result"]["section"] != 0
                    //                 ? "${state.content["result"]["section"]}"
                    //                 : "-"),
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    SfDataGrid(
                      columnWidthMode: ColumnWidthMode.auto,
                      source: _studentMarksSource,
                      columns: <GridColumn>[
                        GridColumn(
                            columnName: 'name',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Subject Name'))),
                        GridColumn(
                            columnName: 'th_fm',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Th FM'))),
                        GridColumn(
                            columnName: 'th_pm',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Th PM'))),
                        GridColumn(
                            columnName: 'pr_fm',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Pr FM'))),
                        GridColumn(
                            columnName: 'pr_pm',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Pr PM'))),
                        GridColumn(
                            columnName: 'th_obt',
                            label: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: Text('Th Obtained'))),
                        GridColumn(
                            columnName: 'pr_obt',
                            label: Container(
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                child: Text('Pr Obtained'))),
                        GridColumn(
                            columnName: 'total',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Total'))),
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Attempted: $all_fm_total'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Total Obtained : $all_obt_total'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Percentage : ' +
                                (_isFail == false ? percentage : "--")),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
                      decoration: BoxDecoration(
                          color:
                              _isFail == false ? Colors.green : Colors.red[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: (Text(
                                _isFail == false
                                    ? "Congratulations!"
                                    : "Sorry!",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.White),
                              )),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(top: 10),
                          //   child: Center(
                          //     child: (Text(
                          //       "${state.content["result"]["student_name"]} has " +
                          //           (_isFail == false ? "Passed!" : "Failed!"),
                          //       style: TextStyle(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.bold,
                          //           color: MyColor.White),
                          //     )),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      decoration: BoxDecoration(color: MyColor.PrimaryColor),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        width: double.infinity,
                        child: Text(
                          "Note: \'A\' indicates that the student did not appear in the particular exam.",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            color: MyColor.SecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}

class Marks {
  /// Creates the Marks class with required details.
  Marks(
      {required this.th_fm,
      required this.name,
      required this.th_pm,
      required this.pr_fm,
      required this.pr_pm,
      required this.th_obt,
      required this.pr_obt,
      required this.total});

  /// Id of an Marks.

  /// Name of an Marks.
  final String name;
  final String th_pm;
  final String th_fm;
  final String pr_pm;
  final String pr_fm;
  final String th_obt;
  final String? pr_obt;
  final String total;
}

/// An object to set the Marks collection data source to the datagrid. This
/// is used to map the Marks data to the datagrid widget.
class MarksDataSource extends DataGridSource {
  MarksDataSource({required List<Marks> marksData}) {
    print('printhinkkjdkj marks daartaa' + marksData.toString());
    _marksData = marksData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'th_fm', value: e.th_fm),
              DataGridCell<String>(columnName: 'th_pm', value: e.th_pm),
              DataGridCell<String>(columnName: 'pr_fm', value: e.pr_fm),
              DataGridCell<String>(columnName: 'pr_pm', value: e.pr_pm),
              DataGridCell<String>(columnName: 'th_obt', value: e.th_obt),
              DataGridCell<String>(
                  columnName: 'pr_obt', value: e.pr_obt ?? '--'),
              DataGridCell<String>(columnName: 'total', value: e.total),
            ]))
        .toList();
  }
  List<DataGridRow> _marksData = [];

  @override
  List<DataGridRow> get rows => _marksData;

  // Object getValue(Marks marks, String columnName) {
  //   switch (columnName) {
  //     case 'name':
  //       return marks.name;

  //     case 'th_fm':
  //       return marks.th_fm;

  //     case 'th_pm':
  //       return (marks.th_fm) == "0" ? "-" : marks.th_pm;

  //     case 'pr_fm':
  //       return (marks.pr_fm) == "0" ? "-" : marks.pr_fm;

  //     case 'pr_pm':
  //       return (marks.pr_pm) == "0" ? "-" : marks.pr_pm;

  //     case 'th_obt':
  //       return marks.th_obt;

  //     case 'pr_obt':
  //       return (marks.pr_fm) == "0" ? "-" : marks.pr_obt;

  //     case 'total':
  //       return marks.total;

  //     default:
  //       return ' ';
  //   }
  // }

  @override
  DataGridRowAdapter buildRow(DataGridRow rows) {
    return DataGridRowAdapter(
        cells: rows.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
