import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/bill_provider.dart';
import 'package:guardiansapp/providers/notice_provider.dart';

class BillRepository {
  BillProvider billProvider = new BillProvider();
  Future getBill({@required token, @required studentId}) async {
    var response = await billProvider.getBill(token, studentId);
    return response;
  }
}
