import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider_student_app/hive/add_student_db.dart';
import 'package:provider_student_app/model/student_model.dart';

class StudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  // Observable variables
  Rx<File?> image = Rx<File?>(null);
  RxList<StudentModel> students = <StudentModel>[].obs;
  RxList<StudentModel> filteredStudents = <StudentModel>[].obs;

  @override
  onInit() {
    super.onInit();
    loadStudent();
  }
  // File? _image;

  // File? get image => _image;

  // List<StudentModel> _students = [];
  // List<StudentModel> _filteredStudents = [];

  // List<StudentModel> get students =>
  //     _filteredStudents.isEmpty ? _students : _filteredStudents;

  // StudentProvider() {
  //   loadStudent();
  // }

  Future<void> loadStudent() async {
    final studentList = await StudentDB().getAllStudents();
    students.assignAll(studentList);
  }

  void updateStudent(int index, StudentModel updateStudent) {
    students[index] = updateStudent;
    students.refresh();
  }

  /////search Function//
  void searchStudent(String query) {
    if (query.isEmpty) {
      filteredStudents.clear();
    } else {
      filteredStudents.assignAll(students.where((student) =>
          student.name.toLowerCase().contains(query.toLowerCase())));
    }
  }

  // Function to delete a student
  Future<void> deleteStudent(int index) async {
    await StudentDB().deleteStudent(index);
    await loadStudent(); // Refresh list after deletion
  }

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  // Function to submit form
  void submitForm(
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      final student = StudentModel(
          name: nameController.text.trim(),
          age: ageController.text.trim(),
          phoneNumber: numberController.text.trim(),
          imagePath: image.value?.path);

      await StudentDB().addStudent(student);
      await loadStudent();
      Get.back();

      Get.snackbar('Success', 'Student details added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Student details added successfully!'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      nameController.clear();
      ageController.clear();
      numberController.clear();
      image.value = null;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    numberController.dispose();
    super.onClose();
  }
}
