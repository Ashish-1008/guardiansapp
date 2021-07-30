import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/MyColors.dart';
import 'package:guardiansapp/blocs/library/library_bloc.dart';
import 'package:guardiansapp/repositories/library_repository.dart';
import 'package:intl/intl.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);
  final BookRepository _bookRepository = new BookRepository();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Library'),
          centerTitle: true,
          backgroundColor: MyColor.PrimaryColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: TabBar(
              ///just for removing default padding
              labelPadding:
                  EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: "Roboto",
              ),
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(
                fontSize: 15,
                fontFamily: "Roboto",
              ),
              tabs: [
                Tab(
                  text: "Returned Books",
                ),
                Tab(
                  text: "Borrowed Books",
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10.0),
          child: BlocProvider(
            create: (context) => LibraryBloc(bookRepository: _bookRepository),
            child: TabBarView(
              children: [
                ReturnedBooks(),
                BorrowedBooks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReturnedBooks extends StatefulWidget {
  ReturnedBooks({Key? key}) : super(key: key);

  @override
  _ReturnedBooksState createState() => _ReturnedBooksState();
}

class _ReturnedBooksState extends State<ReturnedBooks> {
  @override
  void initState() {
    BlocProvider.of<LibraryBloc>(context)
        .add(LibraryButtonPressed(studentId: 1, dataType: 'returned'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
        BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is LibraryLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LibraryLoaded) {
        return ListView(
          padding: EdgeInsets.only(top: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                state.content.length <= 1
                    ? Text(
                        '${state.content.length} Book',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        '${state.content.length} Books',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                Container(
                  height: 30,
                  width: 150,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: MyColor.PaleWhite,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.5,
                      )),
                  child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search Books'),
                      style: TextStyle(
                          fontSize: 11.0,
                          //height: 2.0,
                          color: Colors.black)),
                ),
              ],
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Books',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Author',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Publication',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Borrowed Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Returned Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List.generate(state.content.length, (index) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text('${state.content[index]['book_name']}')),
                      DataCell(Text('${state.content[index]['author']}')),
                      DataCell(Text('${state.content[index]['publication']}')),
                      DataCell(Text(
                        DateFormat.yMd().format(
                          DateTime.parse(state.content[index]['borrow_date']),
                        ),
                      )),
                      DataCell(Text(
                        DateFormat.yMd().format(
                          DateTime.parse(state.content[index]['returned_date']),
                        ),
                      )),
                      // DataCell(Text('Student')),
                    ],
                  );
                }),
              ),
            )
          ],
        );
      }
      return Container();
    }));
  }
}

class BorrowedBooks extends StatefulWidget {
  BorrowedBooks({Key? key}) : super(key: key);

  @override
  _BorrowedBooksState createState() => _BorrowedBooksState();
}

class _BorrowedBooksState extends State<BorrowedBooks> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
        BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is LibraryLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LibraryLoaded) {
        return ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                state.content.length <= 1
                    ? Text(
                        '${state.content.length} Book',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        '${state.content.length} Books',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                Container(
                  height: 30,
                  width: 150,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                      color: MyColor.PaleWhite,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.5,
                      )),
                  child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search Books'),
                      style: TextStyle(
                          fontSize: 11.0,
                          //height: 2.0,
                          color: Colors.black)),
                ),
              ],
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Books',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Author',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Publication',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Borrowed Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Due Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List.generate(state.content.length, (index) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text('${state.content[index]['book_name']}')),
                      DataCell(Text('${state.content[index]['author']}')),
                      DataCell(Text('${state.content[index]['publication']}')),
                      DataCell(Text(
                        DateFormat.yMd().format(
                          DateTime.parse(state.content[index]['borrow_date']),
                        ),
                      )),
                      DataCell(Text(
                        DateFormat.yMd().format(
                          DateTime.parse(state.content[index]['due_date']),
                        ),
                      )),
                      // DataCell(Text('Student')),
                    ],
                  );
                }),
              ),
            )
          ],
        );
      }
      return Container();
    }));
  }
}
