import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class Assignments extends StatefulWidget {
  final String subject;
  final List assignments;
  Assignments({Key? key, required this.subject, required this.assignments})
      : super(key: key);

  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  _showPopUp(assignment) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          assignment['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          'Due Date: ' +
                              DateFormat.yMd().add_jm().format(
                                    DateTime.parse(assignment['due_date']),
                                  ),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Html(
                            data: assignment['description'],
                            style: {
                              'p': Style(
                                fontSize: FontSize(20.0),
                              ),
                            },
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Author : ' + assignment['author']),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assignments'),
        ),
        body: ListView.separated(
            itemCount: widget.assignments.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                title: Text(
                  "${widget.assignments[index]['title']}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Created At: ' +
                      DateFormat.yMd().format(DateTime.parse(
                          "${widget.assignments[index]['created_at']}")),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _showPopUp(widget.assignments[index]);
                  },
                  child: Icon(
                    Icons.visibility,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            }));
  }
}
