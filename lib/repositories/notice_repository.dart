import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/notice_provider.dart';

class NoticeRepository {
  NoticeProvider eventProvider = new NoticeProvider();
  Future fetchNotice({@required token, @required studentId}) async {
    var response = await eventProvider.fetchNotice(token, studentId);
    return response;
  }
}
