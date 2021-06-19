//import 'dart:html';
import 'dart:ui';

import 'package:conexion_lectora/screens/books.dart';
import 'package:conexion_lectora/screens/weeklyBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionsPage extends StatefulWidget {
  static String id = 'collections_page';
  final String correo;
  const CollectionsPage(this.correo);

  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  String qrCode = 'Unknown';
  String corre;
  List<dynamic> listaLibros;
  Stream<QuerySnapshot> query;

  @override
  void initState() {
    super.initState();
    corre = widget.correo; // getStringValuesSF("correoUsuario");
    query = Firestore.instance
        .collection('usuarios')
        .where('correo', isEqualTo: corre)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: query,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
          int academ = 0;
          int inter = 0;
          int entre = 0;
          int curi = 0;
          int histor = 0;

          if (data.hasData) {
            List<dynamic> libros = data.data.documents[0].data['libros'];
            listaLibros = libros;
            for (dynamic libro in libros) {
              switch (libro['categoria']) {
                case 'Academicos':
                  academ++;
                  break;
                case 'Interesantes':
                  inter++;
                  break;
                case 'Entretenidos':
                  entre++;
                  break;
                case 'Curiosos':
                  curi++;
                  break;
                case 'Historicos':
                  histor++;
                  break;
                default:
              }
            }

            return (new Column(
              children: [
                new Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: new Text(
                      "COLECCIONES",
                      style: new TextStyle(
                        // fontFamily: 'Comic-Sans',
                        fontSize: 30,
                        color: const Color(0xFF4f1bb7),
                        decoration: TextDecoration.none,
                      ),
                    ))),
                new ButtonCollection(
                    name: "Academicos",
                    bookCantity: academ,
                    color: Color(0xFF33a198),
                    correo: widget.correo),
                new ButtonCollection(
                    name: "Interesantes",
                    bookCantity: inter,
                    color: Color(0xFF0566ab),
                    correo: widget.correo),
                new ButtonCollection(
                    name: "Entretenidos",
                    bookCantity: entre,
                    color: Color(0xFFd35ee6),
                    correo: widget.correo),
                new ButtonCollection(
                    name: "Curiosos",
                    bookCantity: curi,
                    color: Color(0xFFe3a412),
                    correo: widget.correo),
                new ButtonCollection(
                    name: "Historicos",
                    bookCantity: histor,
                    color: Color(0xFFf2e70c),
                    correo: widget.correo),
              ],
              mainAxisSize: MainAxisSize.max,
            ));
          }

          if (data.hasError) {
            return Center(
              child: Text("Ocurrió un error."),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: const Color(0xFF4f1bb7),
        child: const Icon(Icons.qr_code),
        onPressed: () => scanQRCode(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#4f1bb7',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
        if (qrCode == 'Academicos' ||
            qrCode == 'Historicos' ||
            qrCode == 'Curiosos' ||
            qrCode == 'Interesantes' ||
            qrCode == 'Entretenidos') {
          Route route = MaterialPageRoute(
              builder: (context) => WeeklyBookPage(qrCode, corre, listaLibros));
          Navigator.push(context, route);
        }
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}

class ButtonCollection extends StatelessWidget {
  final String name;
  final int bookCantity;
  final Color color;
  final String correo;

  const ButtonCollection(
      {this.name, this.bookCantity, this.color, this.correo});

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: new SizedBox(
          height: 60,
          child: new TextButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => ViewBookList(
                        name,
                        correo,
                      ));
              Navigator.push(context, route);
            },
            style: new ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                backgroundColor: MaterialStateProperty.all<Color>(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ))),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  name,
                  style: new TextStyle(color: Colors.white),
                ),
                Text(
                  bookCantity.toString(),
                  style: new TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }
}
