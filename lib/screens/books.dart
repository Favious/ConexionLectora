import 'package:conexion_lectora/screens/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewBookList extends StatefulWidget {
  final String categoria;
  final String correo;
  const ViewBookList(this.categoria, this.correo);

  @override
  _ViewBookListState createState() => _ViewBookListState();
}

class _ViewBookListState extends State<ViewBookList> {
  Stream<QuerySnapshot> query;
  String id;
  List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    query = Firestore.instance
        .collection('usuarios')
        .where("correo", isEqualTo: widget.correo)
        // .where("categoria", isEqualTo: widget.categoria)
        .snapshots();
    dataList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
      ),
      body: Center(
        child: StreamBuilder(
          stream: query,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
            if (data.hasData) {
              id = data.data.documents[0].documentID;

              dataList = data.data.documents[0].data['libros'];
              List<dynamic> libros = [];
              for (dynamic d in dataList) {
                if (d['categoria'] == widget.categoria) {
                  libros.add(d);
                }
              }
              if (libros == null || libros.isEmpty) {
                return Center(
                  child: Text("No tiene libros en esta categoria."),
                );
              }

              return ListView.builder(
                itemCount: libros.length,
                itemBuilder: (context, i) {
                  dynamic libro = libros[i];
                  int paginaActual = int.parse(libro['paginaActual']);
                  int paginasTotales = int.parse(libro['numPaginasTotal']);
                  int percent = (paginaActual * 100 / paginasTotales).round();
                  return BookDescriptionButton(
                    coverPagePath: libro['imagen'],
                    bookName: libro["titulo"],
                    authorName: libro["autor"],
                    percent: percent,
                    ultimaPagina: paginaActual,
                    url: libro['linkPDF'],
                    documentID: id,
                    listaLibros: dataList,
                  );
                },
              );
            }

            if (data.hasError) {
              return Center(
                child: Text("Ocurrió un error."),
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class BookDescriptionButton extends StatelessWidget {
  final String coverPagePath;
  final String bookName;
  final String authorName;
  final int ultimaPagina;
  final int percent;
  final String url;
  final String documentID;
  final List<dynamic> listaLibros;

  const BookDescriptionButton(
      {this.coverPagePath,
      this.bookName,
      this.authorName,
      this.ultimaPagina,
      this.percent,
      this.url,
      this.documentID,
      this.listaLibros});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: SizedBox(
          child: TextButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => PDFView(
                        url: url,
                        titulo: bookName,
                        paginaActual: ultimaPagina,
                        documentID: documentID,
                        listaLibros: listaLibros,
                      ));
              Navigator.push(context, route);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
            ),
            child: Row(
              children: [
                CoverPage(coverPagePath),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: BookInfo(bookName, authorName, percent),
                  flex: 1,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "$percent%",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BookInfo extends StatelessWidget {
  final String bookName;
  final String authorName;
  final int percent;

  const BookInfo(this.bookName, this.authorName, this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookName,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          authorName,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 5,
          width: double.infinity,
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}

class CoverPage extends StatelessWidget {
  final String path;

  const CoverPage(this.path);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        path,
        height: 60,
      ),
    );
  }
}
