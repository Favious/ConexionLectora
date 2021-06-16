import 'dart:ui';

import 'package:conexion_lectora/screens/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionsPage extends StatefulWidget {
  static String id = 'collections_page';
  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage>{
  String qrCode = 'Unknown';
  String correo;
  @override
  void initState() {
    super.initState();
      correo= getStringValuesSF("correoUsuario");
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: new Column(
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
                name: "Academicos", bookCantity: 2, color: Color(0xFF33a198)),
            new ButtonCollection(
                name: "Interesantes", bookCantity: 0, color: Color(0xFF0566ab)),
            new ButtonCollection(
                name: "Entretenidos", bookCantity: 0, color: Color(0xFFd35ee6)),
            new ButtonCollection(
                name: "Curiosos", bookCantity: 0, color: Color(0xFFe3a412)),
            new ButtonCollection(
                name: "Historicos", bookCantity: 0, color: Color(0xFFf2e70c)),
          ],
          mainAxisSize: MainAxisSize.max,
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: const Color(0xFF4f1bb7),
          child: const Icon(Icons.qr_code),
          onPressed: () => scanQRCode(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
      );
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
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
  getStringValuesSF(parametro) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString(parametro);
  return stringValue;
  }
  Future<void> importar(context, codigo) async {
    var libro;
    var user;
    try {
      Firestore.instance.collection('libros_semanal').where('categoria', isEqualTo: codigo)
      .snapshots().listen(
        (data) => libro = data.documents[0]
      );
      /*var collec=Firestore.instance.collection("usuarios");
      collec.doc('doc_id').set(yourData, SetOptions(merge: true));*/
 

    } catch(e) {

    }
  }
  }

class ButtonCollection extends StatelessWidget {
  final String name;
  final int bookCantity;
  final Color color;

  const ButtonCollection({this.name, this.bookCantity, this.color});
  // : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: new SizedBox(
          // padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          child: new TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ViewBookList.id);
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