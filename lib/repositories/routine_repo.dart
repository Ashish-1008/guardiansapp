import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/routine_provider.dart';

class RoutineRepository {
  RoutineProvider routineProvider = new RoutineProvider();

  Future getRoutine({
    @required token,
    @required studentId,
  }) async {
    var response = await routineProvider.getRoutine(token, studentId);
    return response;
  }
}
