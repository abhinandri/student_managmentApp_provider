import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_app/controller/add_student_controller.dart';
import 'package:provider_student_app/view/add_student.dart';
import 'package:provider_student_app/view/custome_text.dart';
import 'package:provider_student_app/view/grideview.dart';
import 'package:provider_student_app/view/listview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const CustomText(text: "Student Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: searchController,
                onChanged: (query) {
                  Provider.of<StudentProvider>(context, listen: false)
                      .searchStudent(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // TabBar Below Search Bar
              const TabBar(
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(icon: Icon(Icons.list), text: "List View"),
                  Tab(icon: Icon(Icons.grid_view), text: "Gride View"),
                ],
              ),

              const SizedBox(height: 10),

              // TabBarView
              const Expanded(
                child: TabBarView(
                  children: [
                    StudentListView(), // First tab content
                    StudentGridView(), // Second tab content
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AddStudent())));
          },
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
