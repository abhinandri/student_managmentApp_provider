import 'package:hive/hive.dart';

part 'student_model.g.dart';

// This will be auto-generated

@HiveType(typeId: 0) // Assign a unique type ID
class StudentModel extends HiveObject {
  @HiveField(0) 
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String phoneNumber;

  @HiveField(3)
  String? imagePath; // Optional field for storing image path

  StudentModel({
    required this.name,
    required this.age,
    required this.phoneNumber,
    this.imagePath,
  });
}
