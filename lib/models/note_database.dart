import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], // Ensure NoteSchema is correctly defined
      directory: dir.path,
    );
  }

  // List of notes
  final List<Note> currentNotes = [];

  // Create a new note
  Future<void> addNote(String textFromUser) async {
    // Create a new note object
    final newNote = Note()..text = textFromUser;

    // Save to database
    await isar.writeTxn(() => NoteDatabase.isar.notes.put(newNote));

    // Re-fetch notes from database
    await fetchNotes();
  }

  // Read notes from database
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners(); // Notify listeners (ChangeNotifier)
  }

  // Update a note in the database
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete a note from the database
  Future<void> deleteNote(int id) async {
    await NoteDatabase.isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
