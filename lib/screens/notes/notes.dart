import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class Notes extends StatefulWidget {
  final String subject;
  final List notes;
  Notes({Key? key, required this.subject, required this.notes})
      : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  _showPopUp(notes) {
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
                          notes['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Html(
                            data: notes['description'],
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
                        child: Text('Author : ' + notes['author']),
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
          title: Text('Notes'),
        ),
        body: ListView.separated(
            itemCount: widget.notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                title: Text(
                  "${widget.notes[index]['title']}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Created At: ' +
                      DateFormat.yMd().format(DateTime.parse(
                          "${widget.notes[index]['created_at']}")),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _showPopUp(widget.notes[index]);
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
