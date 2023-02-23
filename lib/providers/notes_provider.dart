import 'package:flutter/cupertino.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }
  
  void fetchNotes() async {
    notes = await ApiService.fetchNotes("rainer");
    notifyListeners();
  }
}