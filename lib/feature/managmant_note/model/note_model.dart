class NoteModel {
  final String id;
  final String title;
  final String content;
  final String categoryId;
  final NoteStatus status;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.status,
    required this.createdAt,
  });

  NoteModel copyWith({
    String? title,
    String? content,
    String? categoryId,
    NoteStatus? status,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }
}

enum NoteStatus { draft, completed }
