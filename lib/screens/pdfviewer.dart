import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PDFViewerPage extends StatefulWidget {
  static String id = 'pdf_viewer_page';
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  
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
      appBar: AppBar(title: Text("Visualizador de PDF"),),
      body: _loading ? Center(child: CircularProgressIndicator(),): PDFViewer(document: _doc),
    );
  }
}