import 'package:flutter/cupertino.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes.where((element) =>
        element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
        element.content!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  void sortNotes() {
    notes.sort((a, b) => a.dateAdded!.compareTo(b.dateAdded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }
  
  void fetchNotes() async {
    notes = await ApiService.fetchNotes("rainer");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}