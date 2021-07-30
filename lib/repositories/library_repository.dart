import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/bill_provider.dart';
import 'package:guardiansapp/providers/library_provider.dart';
import 'package:guardiansapp/providers/notice_provider.dart';

class BookRepository {
  BookProvider bookProvider = new BookProvider();
  Future getBooks(
      {@required token, @required studentId, @required dataType}) async {
    var response = await bookProvider.getBooks(token, studentId, dataType);
    return response;
  }
}
