import 'package:guardiansapp/providers/exam_provider.dart';
import 'package:meta/meta.dart';

class ExamRepository {
  ExamProvider examProvider = new ExamProvider();
  Future getExamForSession({@required token, @required sessionId}) async {
    var response = await examProvider.getExamForSession(token, sessionId);
    return response;
  }
}
