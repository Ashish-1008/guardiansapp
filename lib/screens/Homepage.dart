import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/login/login_bloc.dart';
import 'package:guardiansapp/blocs/notice/notice_bloc.dart';
import 'package:guardiansapp/helper_function.dart';
import 'package:guardiansapp/repositories/authentication_repository.dart';
import 'package:guardiansapp/repositories/notice_repository.dart';
import 'package:guardiansapp/screens/Events.dart';
import 'package:guardiansapp/screens/Notice.dart';

import '../MyColors.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepository userRepository = new UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: HomePageBody());
  }
}

class HomePageBody extends StatefulWidget {
  final user;

  HomePageBody({this.user});
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "Child One"),
    ListItem(2, "Child Two"),
    ListItem(3, "Child Three"),
    ListItem(4, "Child Four")
  ];

  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  late ListItem _selectedItem;
  var _data;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value!;
    getfromshared();
  }

  getfromshared() async {
    var fetchData = await getFromSharedPreferences('response');
    _data = json.decode(fetchData);
    print(_data);
  }

  // EventRepository eventRepository = EventRepository();

  // LoginBloc loginBloc = Get.find<LoginBloc>();
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(
            listItem.name,
            style: TextStyle(color: MyColor.PrimaryColor),
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return _data == null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Container(child: Center(child: CircularProgressIndicator())))
        : Scaffold(
            body: Center(
              child: Container(
                color: MyColor.PaleWhite,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          //Covers top container
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("asset/images/theme.png"),
                                  fit: BoxFit.cover)),
                          child: Column(children: [
                            //Column where oval profile image
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 55, 25, 0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          child: ClipOval(
                                              child: Image.asset(
                                                  'asset/images/man.png')),
                                        )),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: MyColor.SecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                'Edit profile',
                                                style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                ),
                                              ),
                                            )))
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 9, 0, 0),
                              child: Row(children: [
                                Text('Welcome,',
                                    style: TextStyle(
                                      color: MyColor.SecondaryColor,
                                      fontSize: 20,
                                    ))
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Row(children: [
                                Text('${_data['data']['name']}',
                                    style: TextStyle(
                                        color: MyColor.SecondaryColor,
                                        fontFamily: 'Proxima',
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                              child: Row(children: [
                                Container(
                                    height: 35,
                                    width: 130,
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    decoration: BoxDecoration(
                                        color: MyColor.SecondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<ListItem>(
                                          iconEnabledColor:
                                              MyColor.PrimaryColor,
                                          value: _selectedItem,
                                          items: _dropdownMenuItems,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedItem = value!;
                                            });
                                          }),
                                    )),
                              ]),
                            ),
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              25, 20, 0, 0), //Services text only
                          child: Row(
                            children: [
                              Container(
                                  child: Text(
                                'Services',
                                style: TextStyle(
                                    color: MyColor.Black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Notice()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/board.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 5, 0, 0),
                                            child: Text(
                                              'Notice',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Events()));
                                    // BlocProvider.of<EventBloc>(context)
                                    //     .add(EventButtonPressed());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 42,
                                              width: 42,
                                              child: Image.asset(
                                                  'asset/images/calendar.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 14, 0, 0),
                                            child: Text(
                                              'Events',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => Billing()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 45,
                                              width: 45,
                                              child: Image.asset(
                                                  'asset/images/bill.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 14, 0, 0),
                                            child: Text(
                                              'Billing',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => ExamForm()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/result.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              'Result',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => LiveSport()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/live-sports.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              'Live sport',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => AttendanceParent()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/attendance.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              'Attendance',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => Library()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/book.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              'Library',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => ClassroomForm()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/add-friend.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 13, 0, 0),
                                            child: Text(
                                              'Assignment',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => Classroom()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColor.White,
                                    ),
                                    child: Column(children: [
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                  'asset/images/bus.png'))
                                        ],
                                      )),
                                      Container(
                                        child: Row(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 0),
                                            child: Text(
                                              'Notes',
                                              style: TextStyle(
                                                  color: MyColor.PrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ]),
                                      )
                                    ]),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("asset/images/themer.png"),
                        fit: BoxFit.cover,
                      )),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              height: 90,
                              width: 90,
                              child: ClipOval(
                                  child: Image.asset('asset/images/man.png')),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'Sachin Chemjong',
                                style: TextStyle(
                                    color: MyColor.SecondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Icon(
                            Icons.privacy_tip,
                            size: 30,
                            color: MyColor.PrimaryColor,
                          )),
                      Text('Privacy Policy',
                          style: TextStyle(
                              color: MyColor.PrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Icon(
                            Icons.question_answer,
                            size: 30,
                            color: MyColor.PrimaryColor,
                          )),
                      Text('FAQs',
                          style: TextStyle(
                              color: MyColor.PrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Icon(
                            Icons.info,
                            size: 30,
                            color: MyColor.PrimaryColor,
                          )),
                      Text('About us',
                          style: TextStyle(
                              color: MyColor.PrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    height: 0.5,
                    color: MyColor.PrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Icon(
                            Icons.settings,
                            size: 30,
                            color: MyColor.PrimaryColor,
                          )),
                      Text('Settings',
                          style: TextStyle(
                              color: MyColor.PrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LogoutButtonPressed());
                      // Get.offAll(LoginPage());
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) => MyApp()),
                      //     (Route<dynamic> route) => false);
                      getFromSharedPreferences('token');
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Icon(
                              Icons.logout,
                              size: 30,
                              color: MyColor.PrimaryColor,
                            )),
                        Text('Log out',
                            style: TextStyle(
                                color: MyColor.PrimaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
