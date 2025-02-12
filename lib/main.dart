import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/model/student_model.dart';
import 'package:provider_student_app/view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());

  await Hive.openBox<StudentModel>('student');
  Get.put(StudentController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      initialBinding: BindingsBuilder(() {
        Get.put(StudentController());
      }),
    );
  }
}
