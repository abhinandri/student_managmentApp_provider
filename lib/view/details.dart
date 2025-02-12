import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';

import 'package:provider_student_app/model/student_model.dart';

import 'package:provider_student_app/view/custome_text.dart';
import 'package:provider_student_app/view/editPage.dart';

class Details extends StatelessWidget {
  final int index;
  const Details(
      {super.key, required this.index, required StudentModel student});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
        title: CustomText(text: 'About'),
        centerTitle: true,
      ),
      body: Obx(() {
        final student = studentController.students[index];

        return Padding(
          padding: const EdgeInsets.only(top: 44.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: student.imagePath != null
                      ? FileImage(File(student.imagePath!))
                      : null,
                  child: student.imagePath == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Name:${student.name}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Age ${student.age}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "No: ${student.phoneNumber}",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EditPage(
              index: index, student: studentController.students[index]));
        },
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
