import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managmant_note/model/note_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteController', () {
    late NoteController controller;

    setUp(() {
      controller = NoteController();
    });

    test('initial state should have empty notes list', () {
      expect(controller.notes, isEmpty);
    });

    group('addNote', () {
      test('should add a note to the list', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        expect(controller.notes.length, 1);
        expect(controller.notes.first, note);
      });

      test('should add multiple notes', () {
        final note1 = NoteModel(
          id: '1',
          title: 'یادداشت اول',
          content: 'محتوای یادداشت اول',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note2 = NoteModel(
          id: '2',
          title: 'یادداشت دوم',
          content: 'محتوای یادداشت دوم',
          categoryId: 'cat2',
          status: NoteStatus.completed,
          createdAt: DateTime.now(),
        );

        controller.addNote(note1);
        controller.addNote(note2);

        expect(controller.notes.length, 2);
        expect(controller.notes.first, note1);
        expect(controller.notes.last, note2);
      });

      test('should notify listeners when adding a note', () {
        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        expect(notified, isTrue);
      });
    });

    group('removeNote', () {
      test('should remove a note by id', () {
        final note1 = NoteModel(
          id: '1',
          title: 'یادداشت اول',
          content: 'محتوای اول',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note2 = NoteModel(
          id: '2',
          title: 'یادداشت دوم',
          content: 'محتوای دوم',
          categoryId: 'cat2',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note1);
        controller.addNote(note2);

        controller.removeNote(note1);

        expect(controller.notes.length, 1);
        expect(controller.notes.first.id, '2');
      });

      test('should not remove anything if note does not exist', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        final nonExistentNote = NoteModel(
          id: '999',
          title: 'یادداشت وجود ندارد',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.removeNote(nonExistentNote);

        expect(controller.notes.length, 1);
      });

      test('should notify listeners when removing a note', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        controller.removeNote(note);

        expect(notified, isTrue);
      });
    });

    group('updateNote', () {
      test('should update an existing note', () {
        final originalNote = NoteModel(
          id: '1',
          title: 'عنوان اصلی',
          content: 'محتوای اصلی',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(originalNote);

        final updatedNote = originalNote.copyWith(
          title: 'عنوان به‌روز شده',
          content: 'محتوای به‌روز شده',
          status: NoteStatus.completed,
        );

        controller.updateNote(updatedNote);

        expect(controller.notes.length, 1);
        expect(controller.notes.first.title, 'عنوان به‌روز شده');
        expect(controller.notes.first.content, 'محتوای به‌روز شده');
        expect(controller.notes.first.status, NoteStatus.completed);
        expect(controller.notes.first.id, '1');
      });

      test('should not update if note does not exist', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        final nonExistentNote = NoteModel(
          id: '999',
          title: 'یادداشت به‌روز شده',
          content: 'محتوای به‌روز شده',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.updateNote(nonExistentNote);

        expect(controller.notes.length, 1);
        expect(controller.notes.first.title, 'یادداشت تست');
      });

      test('should notify listeners when updating a note', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        final updatedNote = note.copyWith(title: 'یادداشت به‌روز شده');
        controller.updateNote(updatedNote);

        expect(notified, isTrue);
      });
    });

    group('deleteNote', () {
      test('should delete a note by id', () {
        final note1 = NoteModel(
          id: '1',
          title: 'یادداشت اول',
          content: 'محتوای اول',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note2 = NoteModel(
          id: '2',
          title: 'یادداشت دوم',
          content: 'محتوای دوم',
          categoryId: 'cat2',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note1);
        controller.addNote(note2);

        controller.deleteNote(note1);

        expect(controller.notes.length, 1);
        expect(controller.notes.first.id, '2');
      });

      test('should notify listeners when deleting a note', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        controller.deleteNote(note);

        expect(notified, isTrue);
      });
    });

    group('getNotes', () {
      test('should clear all notes', () {
        final note1 = NoteModel(
          id: '1',
          title: 'یادداشت اول',
          content: 'محتوای اول',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note2 = NoteModel(
          id: '2',
          title: 'یادداشت دوم',
          content: 'محتوای دوم',
          categoryId: 'cat2',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note1);
        controller.addNote(note2);

        controller.getNotes();

        expect(controller.notes, isEmpty);
      });

      test('should notify listeners when clearing notes', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        controller.getNotes();

        expect(notified, isTrue);
      });
    });

    group('toggleNoteStatus', () {
      test('should toggle status from draft to completed', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);
        controller.toggleNoteStatus('1');

        expect(controller.notes.first.status, NoteStatus.completed);
      });

      test('should toggle status from completed to draft', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.completed,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);
        controller.toggleNoteStatus('1');

        expect(controller.notes.first.status, NoteStatus.draft);
      });

      test('should not toggle if note does not exist', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);
        controller.toggleNoteStatus('999');

        expect(controller.notes.first.status, NoteStatus.draft);
      });

      test('should notify listeners when toggling status', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        controller.toggleNoteStatus('1');

        expect(notified, isTrue);
      });
    });

    group('getNoteById', () {
      test('should return note when it exists', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        final foundNote = controller.getNoteById('1');

        expect(foundNote, isNotNull);
        expect(foundNote?.id, '1');
        expect(foundNote?.title, 'یادداشت تست');
      });

      test('should return null when note does not exist', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        final foundNote = controller.getNoteById('999');

        expect(foundNote, isNull);
      });

      test('should return null when list is empty', () {
        final foundNote = controller.getNoteById('1');

        expect(foundNote, isNull);
      });
    });

    group('getNotesByCategory', () {
      test('should return notes filtered by category', () {
        final note1 = NoteModel(
          id: '1',
          title: 'یادداشت اول',
          content: 'محتوای اول',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note2 = NoteModel(
          id: '2',
          title: 'یادداشت دوم',
          content: 'محتوای دوم',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        final note3 = NoteModel(
          id: '3',
          title: 'یادداشت سوم',
          content: 'محتوای سوم',
          categoryId: 'cat2',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note1);
        controller.addNote(note2);
        controller.addNote(note3);

        final categoryNotes = controller.getNotesByCategory('cat1');

        expect(categoryNotes.length, 2);
        expect(
          categoryNotes.every((note) => note.categoryId == 'cat1'),
          isTrue,
        );
      });

      test('should return empty list when no notes match category', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        final categoryNotes = controller.getNotesByCategory('cat999');

        expect(categoryNotes, isEmpty);
      });

      test('should return empty list when notes list is empty', () {
        final categoryNotes = controller.getNotesByCategory('cat1');

        expect(categoryNotes, isEmpty);
      });
    });

    group('notes getter', () {
      test('should return unmodifiable list', () {
        final note = NoteModel(
          id: '1',
          title: 'یادداشت تست',
          content: 'محتوای تست',
          categoryId: 'cat1',
          status: NoteStatus.draft,
          createdAt: DateTime.now(),
        );

        controller.addNote(note);

        expect(
          () => controller.notes.add(note),
          throwsA(isA<UnsupportedError>()),
        );
      });
    });
  });
}
