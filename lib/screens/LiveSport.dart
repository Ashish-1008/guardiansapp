import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/liveSport/livesport_bloc.dart';
import 'package:guardiansapp/repositories/liveSport_repository.dart';
import 'package:http/http.dart';
import '../MyColors.dart';

class LiveSportsPage extends StatelessWidget {
  LiveSportRepository _liveSportRepository = new LiveSportRepository();
  LiveSportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
          child: LiveSport(),
          create: (context) =>
              LiveSportBloc(liveSportRepository: _liveSportRepository)
                ..add(LiveSportButtonPressed())),
    );
  }
}

class LiveSport extends StatefulWidget {
  @override
  _LiveSportState createState() => _LiveSportState();
}

class _LiveSportState extends State<LiveSport> {
  Color getColor(color) {
    switch (color) {
      case 'red':
        {
          return Colors.red;
        }

      case 'blue':
        {
          return Colors.blue;
        }
      case 'green':
        {
          return Colors.green;
        }
      default:
        {
          return Colors.yellow;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.PrimaryColor,
          title: Text('Live Sports'),
        ),
        body: BlocBuilder<LiveSportBloc, LiveSportState>(
          builder: (context, state) {
            if (state is LiveSportLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LiveSportLoaded) {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                    );
                  },
                  itemCount: state.content.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: MyColor.White,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text(
                                      '${state.content[index]['team_a_name']}  vs  ${state.content[index]['team_b_name']}',
                                      style: TextStyle(
                                        color: MyColor.SecondaryColor,
                                        fontSize: 13,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 3),
                                  margin: EdgeInsets.only(right: 15),
                                  height: 20,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text('LIVE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: MyColor.SecondaryColor,
                                        fontSize: 13,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  color: getColor(
                                                      state.content[index]
                                                          ['team_a_color']),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                      '${state.content[index]['team_a_name']}',
                                                      style: TextStyle(
                                                          //color: MyColor.SecondaryColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              child: state.content[index]
                                                          ['team_a_score'] !=
                                                      null
                                                  ? Text(
                                                      '${state.content[index]['team_a_score']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        //color: MyColor.SecondaryColor,
                                                        fontSize: 30,
                                                        //fontWeight: FontWeight.bold
                                                      ))
                                                  : Text('0',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        //color: MyColor.SecondaryColor,
                                                        fontSize: 30,
                                                        //fontWeight: FontWeight.bold
                                                      ))),
                                          Container(
                                            child: Text('-',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  //color: MyColor.SecondaryColor,
                                                  fontSize: 30,
                                                  //fontWeight: FontWeight.bold
                                                )),
                                          ),
                                          Container(
                                            child: state.content[index]
                                                        ['team_b_score'] !=
                                                    null
                                                ? Text(
                                                    '${state.content[index]['team_b_score']}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      //color: MyColor.SecondaryColor,
                                                      fontSize: 30,
                                                      //fontWeight: FontWeight.bold
                                                    ))
                                                : Text(
                                                    '0',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      //color: MyColor.SecondaryColor,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  color: getColor(
                                                      state.content[index]
                                                          ['team_b_color']),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                      '${state.content[index]['team_b_name']}',
                                                      style: TextStyle(
                                                          //color: MyColor.SecondaryColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    );
                  });
            }
            return Container();
          },
        )
        // Container(
        //   height: 180,
        //   color: MyColor.PrimaryColor,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         padding: EdgeInsets.fromLTRB(0, 35, 10, 10),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             IconButton(
        //                 icon: Icon(
        //                   Icons.arrow_back,
        //                   color: MyColor.SecondaryColor,
        //                 ),
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 }),
        //             Container(
        //                 child: Text('Live Sports',
        //                     style: TextStyle(
        //                         color: MyColor.SecondaryColor,
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.bold))),
        //             IconButton(
        //                 icon: Icon(
        //                   Icons.more_vert,
        //                   color: MyColor.SecondaryColor,
        //                 ),
        //                 onPressed: null),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         height: 50,
        //         margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
        //         padding: EdgeInsets.symmetric(horizontal: 20),
        //         decoration: BoxDecoration(
        //             color: MyColor.SecondaryColor,
        //             borderRadius: BorderRadius.circular(20)),
        //         child: TextField(
        //             decoration: InputDecoration(
        //                 enabledBorder: InputBorder.none,
        //                 focusedBorder: InputBorder.none,
        //                 hintText: 'Search Sports'),
        //             style: TextStyle(
        //                 fontSize: 15.0,
        //                 height: 2.0,
        //                 color: Colors.black)),
        //       ),
        //     ],
        //   ),
        // ),

        );
  }
}
