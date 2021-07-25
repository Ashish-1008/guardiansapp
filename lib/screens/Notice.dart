import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/notice/notice_bloc.dart';
import 'package:guardiansapp/repositories/notice_repository.dart';
import 'package:guardiansapp/screens/notice_desc.dart';

import 'package:intl/intl.dart';

import '../MyColors.dart';

class Notice extends StatelessWidget {
  NoticeRepository noticeRepository = new NoticeRepository();
  Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => NoticeBloc(noticeRepository: noticeRepository)
          ..add(NoticeButtonPressed(studentId: 1)),
        child: NoticeSection(),
      ),
    );
  }
}

class NoticeSection extends StatefulWidget {
  @override
  _NoticeSectionState createState() => _NoticeSectionState();
}

class _NoticeSectionState extends State<NoticeSection> {
  // ignore: non_constant_identifier_names
  List<double> Height = [0.0, 0.0];

  void GetHeight() {
    for (int i = 0; i <= 10; i++) {
      Height.add(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    //GetHeight();
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColor.PrimaryColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: MyColor.SecondaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          'Notice',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: MyColor.SecondaryColor),
        ),
      ),
      body: Container(
        color: MyColor.PaleWhite,
        child: BlocBuilder<NoticeBloc, NoticeState>(
          builder: (context, state) {
            if (state is NoticeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NoticeLoaded) {
              return ListView.builder(
                itemCount: state.content.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  NoticeDescription(state.content[index])));
                    },
                    child: Card(
                      child: ListTile(
                          title: Text(state.content[index]["notice_title"]),
                          subtitle: Text(DateFormat.yMMMMd()
                              .format(DateTime.parse(
                                  state.content[index]["created_at"]))
                              .toString())),
                    ),
                  );
                },
              );
            }
            if (state is NoticeLoadingFailure) {
              return Center(
                  child: Container(
                child: Text("${state.error}"),
              ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
