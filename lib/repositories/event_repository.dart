import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/event_provider.dart';

class EventRepository {
  EventProvider eventProvider = new EventProvider();
  Future fetchEvents({@required token, @required studentId}) async {
    var response = await eventProvider.fetchEvent(token, studentId);
    return response;
  }
}
