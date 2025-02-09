import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/model/student_model.dart';
import 'package:provider_student_app/view/custome_text.dart';

class EditPage extends StatelessWidget {
  final int index;
  final StudentModel student;

  const EditPage({super.key, required this.index, required this.student});

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    TextEditingController nameController =
        TextEditingController(text: student.name);
    TextEditingController ageController =
        TextEditingController(text: student.age);
    TextEditingController numberController =
        TextEditingController(text: student.phoneNumber);
    File? imageFile =
        student.imagePath != null ? File(student.imagePath!) : null;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: CustomText(
          text: "Edit Student",
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    imageFile = File(pickedFile.path);
                  }
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                  child: imageFile == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  final updatedStudent = StudentModel(
                    name: nameController.text.trim(),
                    age: ageController.text.trim(),
                    phoneNumber: numberController.text.trim(),
                    imagePath: imageFile?.path,
                  );
                  studentProvider.updateStudent(index, updatedStudent);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
