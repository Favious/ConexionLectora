//import 'dart:html';
import 'package:conexion_lectora/screens/books.dart';
import 'package:conexion_lectora/screens/login.dart';
import 'package:conexion_lectora/screens/pdfviewer.dart';
import 'package:conexion_lectora/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/collections.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conexion Lectora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xFF4f1bb7),
        accentColor: const Color(0xFF4f1bb7),
        textTheme: TextTheme(
          headline6: TextStyle(
            // estilo para titulo del libro
            color: Colors.black,
            fontSize: 18,
          ),
          headline5: TextStyle(
            // estilo para el nombre del autor
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        CollectionsPage.id: (context) => CollectionsPage(),
        ViewBookList.id: (context) => ViewBookList(),
        PDFView.id: (context) => PDFView()
      },
    );
  }
}
