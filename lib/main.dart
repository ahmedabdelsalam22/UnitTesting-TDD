import 'package:flutter/material.dart';
import 'package:posts_with_unit_testing/presentation/posts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Unit Testing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsPage(),
    );
  }
}
