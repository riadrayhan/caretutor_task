import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'add_list.dart';
import 'note_controller.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO App'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.add,color: Colors.white,),
            onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddItemPage(),));
            });
            },
          )
        ],
      ),
      body: Obx(() {
        if (noteController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: noteController.notes.length,
            itemBuilder: (context, index) {
              final note = noteController.notes[index];
              return Card(
                elevation: 4,
                child: ListTile(
                  title: Text(note['title'],style: TextStyle(color: Colors.deepOrange),),
                  subtitle: Text(note['description'],style: TextStyle(color: Colors.orange[200]),),
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,),
                    onPressed: () => noteController.deleteNote(note['_id']),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}