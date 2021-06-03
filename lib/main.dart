import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String url= "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf";
  String pdfasset ="assets/sample.pdf";
  PDFDocument _doc;
  bool _loading;
  @override
  void initState() {
    
    super.initState();
    _initPdf();
  }

   _initPdf() async {
     
      setState(() {
        _loading=true;
      });
      PDFDocument docu= await PDFDocument.fromURL(url);
      final doc = docu;
      
      setState(() {
        _doc=doc;
        _loading=false;
      });
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter PDF Demo"),),
      body: _loading ? Center(child: CircularProgressIndicator(),): PDFViewer(document: _doc),
    );
  }
}
