import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/view/custome_text.dart';
import 'package:provider_student_app/view/details.dart';

class StudentGridView extends StatelessWidget {
   StudentGridView({super.key});

  final StudentController studentController=Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final studentList=studentController.filteredStudents.isEmpty?studentController.students:studentController.filteredStudents;

      if(studentList.isEmpty){
        return Center(child: Text('No students added yet!'),);
      }


       return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Adjust item size
          ),
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            var student = studentList[index];
            return GestureDetector(
              onTap: (){
                Get.to(()=>Details(index: index, student: student));
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    student.imagePath != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: FileImage(File(student.imagePath!)),
                          )
                        : const Icon(Icons.person, size: 50),
                    const SizedBox(height: 8),
                    Text(student.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Age: ${student.age}"),
                    Text("Phone: ${student.phoneNumber}"),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDeleteDialog(context, studentController, index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );


    });

     
       
      }
    
  }


void showDeleteDialog(
    BuildContext context, StudentController controller, int index) {
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
              controller.deleteStudent(index);
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
