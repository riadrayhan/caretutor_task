import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'note_controller.dart';


class AddItemPage extends StatelessWidget {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
 // final TextEditingController textController = TextEditingController();
  final NoteController noteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: titleController,
             decoration: const InputDecoration(
               hintText: 'Insert your Text',
               labelText: 'Title',
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(10))
               )
             ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Insert your Description',
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  )
              ),
            ),
            // TextField(
            //   controller: textController,
            //   decoration: InputDecoration(labelText: 'Text'),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
            //       noteController.addNote(
            //         title: titleController.text,
            //         description: descriptionController.text, text: '',
            //         // text: textController.text,
            //       );
            //       Get.back(); // Go back to the HomePage
            //     } else {
            //       Get.snackbar('Error', 'Title and Description cannot be empty');
            //     }
            //   },
            //   child: Text('Add Note'),
            // ),
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton.extended(onPressed: () {
       if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
         noteController.addNote(
           title: titleController.text,
           description: descriptionController.text, text: '',
           // text: textController.text,
         );
         Get.back(); // Go back to the HomePage
       } else {
         Get.snackbar('Error', 'Title and Description cannot be empty');
       }
     },label: Text("Item Add"),),
    );
  }
}