import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/assignment_provider.dart';

class AssignmentRepository {
  AssignmentProvider assignmentProvider = new AssignmentProvider();

  Future getAssignment({
    @required token,
    @required studentId,
  }) async {
    var response = await assignmentProvider.getAssignment(token, studentId);
    return response;
  }
}
