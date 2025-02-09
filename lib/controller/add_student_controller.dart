import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider_student_app/hive/add_student_db.dart';
import 'package:provider_student_app/model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  File? _image;

  File? get image => _image;

  List<StudentModel> _students = [];
  List<StudentModel> _filteredStudents = [];

  List<StudentModel> get students =>
      _filteredStudents.isEmpty ? _students : _filteredStudents;

  StudentProvider() {
    loadStudent();
  }
  Future<void> loadStudent() async {
    _students = await StudentDB().getAllStudents();
    notifyListeners();
  }

  void updateStudent(int index, StudentModel updateStudent) {
    _students[index] = updateStudent;
    notifyListeners();
  }

  /////search Function//
  void searchStudent(String query) {
    if (query.isEmpty) {
      _filteredStudents = [];
    } else {
      _filteredStudents = _students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
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
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Function to submit form
  void submitForm(BuildContext context, ) async {
    if (formKey.currentState!.validate()) {
      final student = StudentModel(
          name: nameController.text.trim(),
          age: ageController.text.trim(),
          phoneNumber: numberController.text.trim(),
          imagePath: _image?.path);

      await StudentDB().addStudent(student);
      await loadStudent();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student details added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      nameController.clear();
      ageController.clear();
      numberController.clear();
      _image = null;

      notifyListeners();

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    numberController.dispose();
    super.dispose();
  }
}
