import 'dart:convert';
import 'dart:developer';

import 'package:notes_app_flutter/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://10.0.2.2:3000/api/v1";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes");
    var response = await http.delete(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userId) async {
    Uri requestUri = Uri.parse("$_baseUrl/notes/$userId");
    var response = await http.get(requestUri);
    var decoded = jsonDecode(response.body);

    List<Note> notes = [];

    for(var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}