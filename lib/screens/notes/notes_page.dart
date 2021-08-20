import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/assignment/assignment_bloc.dart';
import 'package:guardiansapp/blocs/notes/notes_bloc.dart';
import 'package:guardiansapp/repositories/notes_repository.dart';
import 'package:guardiansapp/screens/assignment/assignments.dart';
import 'package:guardiansapp/screens/notes/notes.dart';

class SubjectPageForNotes extends StatelessWidget {
  NotesRepository _notesRepository = new NotesRepository();
  SubjectPageForNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => NotesBloc(notesRepository: _notesRepository)
          ..add(NotesButtonPressed(studentId: 1)),
        child: Subjects(),
      ),
    );
  }
}

class Subjects extends StatefulWidget {
  Subjects({Key? key}) : super(key: key);

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List _subjects = [
    {
      'name': 'Science',
      'image': 'asset/images/science.jpg',
    },
    {
      'name': 'Mathematics',
      'image': 'asset/images/math.jpg',
    },
    {
      'name': 'Computer Science',
      'image': 'asset/images/computer science.jpg',
    },
    {
      'name': 'Social Studies',
      'image': 'asset/images/social.jpg',
    },
    {
      'name': 'English',
      'image': 'asset/images/english.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotesLoaded) {
            return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _subjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height * 0.09) /
                            (MediaQuery.of(context).size.width * 0.2)),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Map<String, dynamic> _subjName = {};

                      for (int i = 0; i < state.content['notes'].length; i++) {
                        _subjName['${state.content['notes'][i]['subject']}'] =
                            state.content['notes'][i]['notes'];
                      }
                      if (_subjName.keys.contains(_subjects[index]['name'])) {
                        List _notes = _subjName[_subjects[index]['name']];

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Notes(
                                      subject: _subjects[index]['name'],
                                      notes: _notes,
                                    )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                                'Sorry!! No assignment for selected subject')));
                      }
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(_subjects[index]['image']),
                            height: 120,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${_subjects[index]['name']}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
