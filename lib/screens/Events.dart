import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/event/event_bloc.dart';
import 'package:guardiansapp/repositories/event_repository.dart';
import 'package:guardiansapp/screens/event_desc.dart';

import 'package:url_launcher/url_launcher.dart';

import '../MyColors.dart';

class Events extends StatelessWidget {
  final EventRepository eventRepository = new EventRepository();

  Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => EventBloc(eventRepository: eventRepository)
          ..add(EventButtonPressed(studentId: 1)),
        child: EventBody(),
      ),
    );
  }
}

class EventBody extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<EventBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Events'),
          centerTitle: true,
          backgroundColor: MyColor.PrimaryColor,
        ),
        body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
          if (state is EventLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EventLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              itemCount: (state.content).length,
              itemBuilder: (context, index) {
                print(state.content);
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      EventDescription(state.content[index])));
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: state.content[index]["image"] != null
                                      ? NetworkImage(
                                          state.content[index]["image"])
                                      : Icon(Icons.image) as ImageProvider,
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                color: Color(0x22000000),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: Text(
                                            state.content[index]['title'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColor.White,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 20, 10),
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: MyColor.White,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final url =
                                                      state.content[index]
                                                          ['event_link'];
                                                  print(url);

                                                  if (url != null) {
                                                    await launch(url);
                                                  }
                                                },
                                                child: Text(
                                                  'Visit us',
                                                  style: TextStyle(
                                                      color: MyColor.PaleDark),
                                                ),
                                              ),
                                            )))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: MyColor.PaleDark,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                                    child: Text(
                                      state.content[index]['date'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MyColor.PaleDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch,
                                    color: MyColor.PaleDark,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 2, 0, 0),
                                    child: Text(
                                      state.content[index]['time'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MyColor.PaleDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: MyColor.PaleDark,
                              size: 25,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                              child: Text(
                                'Venue: ${state.content[index]['venue']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyColor.PaleDark,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container();
              },
            );
          }
          if (state is EventLoadingFailure) {
            return Center(
              child: Text("${state.error}"),
            );
          }
          return Container();
        }));
  }
}
