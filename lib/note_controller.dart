import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteController extends GetxController {
  var notes = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/notes'));
      if (response.statusCode == 200) {
        notes.value = List<Map<String, dynamic>>.from(json.decode(response.body).map((note) {
          return {
            'title': note['title'] ?? 'Untitled',
            'description': note['description'] ?? 'No description available',
            // 'text': note['text'] ?? '',
            'createdAt': note['createdAt'] ?? '',
            '_id': note['_id'],
          };
        }));
      } else {
        print('Failed to load notes');
      }
    } catch (e) {
      print('Error fetching notes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNote({
    required String title,
    required String description,
    required String text,
  }) async {
    final note = {
      'title': title,
      'description': description,
      // 'text': text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/notes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(note),
      );

      if (response.statusCode == 201) {
        fetchNotes();
      } else {
        print('Failed to add note');
      }
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/notes/$id'));

      if (response.statusCode == 204) {
        fetchNotes();
      } else {
        print('Failed to delete note');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}