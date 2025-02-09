import 'package:hive/hive.dart';
import 'package:provider_student_app/model/student_model.dart';

class StudentDB {
  String boxName = 'students';

  Future<Box<StudentModel>> openBox() async {
    return await Hive.openBox<StudentModel>(boxName);
  }

  Future<void> addStudent(StudentModel student) async {
    final box = await openBox();
    await box.add(student);
      print("🔹 Adding student: ${student.name}, Age: ${student.age}, Phone: ${student.phoneNumber}");
  }

  Future<List<StudentModel>> getAllStudents() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> deleteStudent(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
  }

  Future<void> updateStudent(int index, StudentModel student) async {
    final box = await openBox();
    await box.putAt(index, student);
  }

  Future<void> clearAll() async {
    final box = await openBox();
    await box.clear();
  }
}
