import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/liveSport_provider.dart';

class LiveSportRepository {
  LiveSportProvider liveSportProvider = new LiveSportProvider();

  Future getLiveSport({
    @required token,
  }) async {
    var response = await liveSportProvider.getLiveSports(token);
    return response;
  }
}
