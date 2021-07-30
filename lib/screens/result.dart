import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/exam/exam_bloc.dart';
import 'package:guardiansapp/blocs/marks/marks_bloc.dart';
import 'package:guardiansapp/repositories/exam_repository.dart';
import 'package:guardiansapp/repositories/marks_repository.dart';
import 'package:guardiansapp/screens/Homepage.dart';
import 'package:guardiansapp/screens/finalresult.dart';

class Session extends StatelessWidget {
  MarksRepository marksRepository = new MarksRepository();
  Session({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            child: SessionSelectPage(),
            create: (context) => MarksBloc(marksRepository: marksRepository)
              ..add(MarksButtonPressed(studentId: 1))));
  }
}

class SessionSelectPage extends StatefulWidget {
  SessionSelectPage({Key? key}) : super(key: key);

  @override
  _SessionSelectPageState createState() => _SessionSelectPageState();
}

class _SessionSelectPageState extends State<SessionSelectPage> {
  String? _selectedSession;
  String? _selectedExam;
  ExamRepository examRepository = new ExamRepository();

  List<dynamic> _session = [];
  List<dynamic> _exams = [];
  _prepareDropDown(data) {
    _session = data;
  }

  _prepareDropDownForExam(data) {
    _exams = data;
  }

  ExamBloc? _examBloc;
  @override
  void initState() {
    _examBloc = new ExamBloc(examRepository: examRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Session and Exam'),
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: BlocBuilder<MarksBloc, MarksState>(
        builder: (context, state) {
          if (state is SessionLoading) {
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
                      Get.off(HomePage());
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
          if (state is SessionLoaded) {
            _prepareDropDown(state.content);

            return ListView(
              padding: const EdgeInsets.only(left: 20, right: 20),
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Choose Session",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: new DropdownButton<String>(
                              value: _selectedSession,
                              hint: Text("Select session"),
                              isExpanded: true,
                              underline: Container(),
                              items: _session.map((value) {
                                return new DropdownMenuItem<String>(
                                  value: "${value['id']}",
                                  child: Text('${value['year']}'),
                                );
                              }).toList(),
                              onChanged: (selectedVal) {
                                setState(() {
                                  _selectedSession = selectedVal!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Search Exam",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // ignore: unnecessary_null_comparison
                            if (_selectedSession == null) {
                              Get.snackbar("Error!", "Select all the fields!",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red[300],
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              _examBloc!.add(SearchExamButtonPressed(
                                  sessionId: _selectedSession));
                            }
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                BlocBuilder<ExamBloc, ExamState>(
                    bloc: _examBloc,
                    builder: (context, state) {
                      if (state is ExamLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ExamLoadingFailure) {
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
                                  Get.off(HomePage());
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
                      if (state is ExamLoaded) {
                        _prepareDropDownForExam(state.content);
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                "Choose Exam",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Form(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: new DropdownButton<String>(
                                          value: _selectedExam,
                                          hint: Text("Select Exam"),
                                          isExpanded: true,
                                          underline: Container(),
                                          items: _exams.map((value) {
                                            return new DropdownMenuItem<String>(
                                              value: "${value['id']}",
                                              child: Text('${value['label']}'),
                                            );
                                          }).toList(),
                                          onChanged: (selectedVal) {
                                            setState(() {
                                              _selectedExam = selectedVal!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      height: 55,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "View Result",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => FinalResult(
                                                      examId: _selectedExam,
                                                      sessionId:
                                                          _selectedSession,
                                                      studentId: 1,
                                                    )));
                                      },
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
