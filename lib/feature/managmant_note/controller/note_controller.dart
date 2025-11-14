import 'package:Notim/feature/managmant_note/model/note_model.dart';
import 'package:flutter/material.dart';

class NoteController extends ChangeNotifier {
  List<NoteModel> _notes = [];
  List<NoteModel> get notes => List.unmodifiable(_notes);
  void addNote(NoteModel note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(NoteModel note) {
    _notes.removeWhere((item) => item.id == note.id);
    notifyListeners();
  }

  void updateNote(NoteModel updatedNote) {
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(NoteModel note) {
    _notes.removeWhere((item) => item.id == note.id);
    notifyListeners();
  }

  void getNotes() {
    _notes = [];
    notifyListeners();
  }

  void toggleNoteStatus(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final note = _notes[index];
      final newStatus = note.status == NoteStatus.draft
          ? NoteStatus.completed
          : NoteStatus.draft;

      _notes[index] = note.copyWith(status: newStatus);
      notifyListeners();
    }
  }

  NoteModel? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  List<NoteModel> getNotesByCategory(String categoryId) {
    return _notes.where((note) => note.categoryId == categoryId).toList();
  }
}
