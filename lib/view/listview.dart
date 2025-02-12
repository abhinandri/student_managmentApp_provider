import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';

import 'package:provider_student_app/view/custome_text.dart';
import 'package:provider_student_app/view/details.dart';

class StudentListView extends StatelessWidget {
  StudentListView({super.key});
  final StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final studentList = studentController.filteredStudents.isEmpty
          ? studentController.students
          : studentController.filteredStudents;

      if (studentList.isEmpty) {
        return Center(
          child: Text('No students added yet!'),
        );
      }

      return ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          var student = studentList[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => Details(index: index, student: student));
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
                  onPressed: () => showDeleteDialog(index, studentController),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

void showDeleteDialog(int index, StudentController studentController) {
  Get.defaultDialog(
    title: 'Confirm Deletion',
    content: const CustomText(
      text: 'Are you sure you want to delete this student?',
      color: Colors.black,
      fontSize: 16,
    ),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel', style: TextStyle(color: Colors.black)),
      ),
      TextButton(
        onPressed: () {
          studentController.deleteStudent(index);
          Get.back();
        },
        child: const Text('Delete',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ),
    ],
  );
}
