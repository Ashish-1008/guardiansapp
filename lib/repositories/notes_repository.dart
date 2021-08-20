import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/notes_provider.dart';

class NotesRepository {
  NotesProvider notesProvider = new NotesProvider();

  Future getNotes({
    @required token,
    @required studentId,
  }) async {
    var response = await notesProvider.getNotes(token, studentId);
    return response;
  }
}
