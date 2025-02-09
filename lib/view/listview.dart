
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/view/custome_text.dart';
import 'package:provider_student_app/view/details.dart';


class StudentListView extends StatelessWidget {
  const StudentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, child) {
        if (provider.students.isEmpty) {
          return const Center(child: Text("No students added yet!"));
        }
        return ListView.builder(
          itemCount: provider.students.length,
          itemBuilder: (context, index) {
            var student = provider.students[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(student:student, index: index,)));
              },
              child: Card(
                child: ListTile(
                  leading: student.imagePath != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(student.imagePath!)))
                      : const Icon(Icons.person),
                  title: Text(student.name),
                  subtitle:
                      Text("Age: ${student.age}, Phone: ${student.phoneNumber}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDeleteDialog(context, provider, index);
                      // provider.deleteStudent(index);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

void showDeleteDialog(
    BuildContext context, StudentProvider provider, int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const CustomText(
          text: 'Confirm Deletion',
          color: Colors.black,
        ),
        content: const CustomText(
          text: 'Are you sure you want to delete this student?',
          color: Colors.black,
          fontSize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              provider.deleteStudent(index);
              Navigator.pop(context); // Close dialog after deleting
            },
            child: const Text('Delete',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}
