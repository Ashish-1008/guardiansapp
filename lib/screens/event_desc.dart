import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import '../MyColors.dart';

class EventDescription extends StatelessWidget {
  var content;

  EventDescription(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Description'),
        centerTitle: true,
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * (0.95),
          child: ListView(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(content['image']),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  content['title'],
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      content['venue'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              content['date'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.alarm,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              content['time'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Time',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'About Event',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Html(
                  data: content['description'],
                  style: {
                    'p': Style(
                      fontSize: FontSize(18.0),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
