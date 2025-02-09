import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/controller/splash_controller.dart';
import 'package:provider_student_app/model/student_model.dart';
import 'package:provider_student_app/view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());

  await Hive.openBox<StudentModel>('student');

  runApp(
    MultiProvider(providers: [
      // ChangeNotifierProvider(create: (context) => SplashController()),
      ChangeNotifierProvider(create: (context) => StudentProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
