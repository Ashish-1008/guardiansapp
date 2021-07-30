import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/marks/marks_bloc.dart';
import 'package:guardiansapp/repositories/marks_repository.dart';
import 'package:guardiansapp/screens/Homepage.dart';

class FinalResult extends StatelessWidget {
  final studentId;
  final sessionId;
  final examId;
  MarksRepository marksRepository = new MarksRepository();
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

class _ResultPageState extends State<ResultPage> {
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
        return Container();
      }),
    );
  }
}
