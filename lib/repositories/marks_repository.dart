import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/marks_provider.dart';

class MarksRepository {
  MarksProvider marksProvider = new MarksProvider();
  Future getSessions({@required token, @required studentId}) async {
    var response = await marksProvider.getSession(token, studentId);
    return response;
  }

  Future getMarksForSession(
      {@required token,
      @required sessionId,
      @required examId,
      @required studentId}) async {
    var response = await marksProvider.getMarksForSession(
        token, sessionId, examId, studentId);
    return response;
  }
}
