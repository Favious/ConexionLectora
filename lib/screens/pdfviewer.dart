import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

void main() => runApp(PDFView());

class PDFView extends StatefulWidget {
  final String url;
  final String titulo;
  final int paginaActual;
  final String documentID;
  final List<dynamic> listaLibros;

  const PDFView(
      {this.url,
      this.titulo,
      this.paginaActual,
      this.documentID,
      this.listaLibros});

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  bool _isLoading = true;
  PDFDocument document;
  int page = 0;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for (dynamic libro in widget.listaLibros) {
          if (libro['linkPDF'] == widget.url) {
            libro['paginaActual'] = page.toString();
            break;
          }
        }

        await Firestore.instance
            .collection('usuarios')
            .document(widget.documentID)
            .updateData({'libros': widget.listaLibros});

        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.titulo),
          ),
          body: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(
                    document: document,
                    zoomSteps: 1,
                    //uncomment below line to preload all pages
                    lazyLoad: false,
                    // uncomment below line to scroll vertically
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      page = value;
                    },
                    pickerButtonColor: Theme.of(context).accentColor,
                    //uncomment below code to replace bottom navigation with your own
                    navigationBuilder:
                        (context, page, totalPages, jumpToPage, animateToPage) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.first_page),
                            onPressed: () {
                              jumpToPage(page: 0);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              animateToPage(page: page - 2);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              animateToPage(page: page);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark, color: Colors.red[900]),
                            onPressed: () {
                              jumpToPage(page: widget.paginaActual);
                            },
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
