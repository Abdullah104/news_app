import 'package:flutter/material.dart';

import 'views/widgets/custom_bottom_navbar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const CustomBottomNavbar(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
