//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyBookPage extends StatefulWidget {
  final String categoria;
  final String correo;
  final List<dynamic> libros;
  const WeeklyBookPage(this.categoria, this.correo, this.libros);
  _WeeklyBookPage createState() => _WeeklyBookPage();
}

class _WeeklyBookPage extends State<WeeklyBookPage> {
  String titulo = "Taller de BD";
  String portada = "https://imagessl3.casadellibro.com/a/l/t7/13/9788483468913.jpg";
  var libro;
  var query;
  var query2;
  var id;

  @override
  void initState() {
    super.initState(); // getStringValuesSF("correoUsuario");
    query = Firestore.instance
        .collection('libros_semanal')
        .where('categoria', isEqualTo: widget.categoria)
        .snapshots();
    query2 = Firestore.instance
        .collection('usuarios')
        .where('correo', isEqualTo: widget.correo)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: query, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data){
        if(data.hasData) {
          libro = data.data.documents[0].data;
        return Scaffold(
          appBar: AppBar(
              title: Text(titulo),
            ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Image.network(portada,
                    height: 500.0,
                    ),
                ),
                SizedBox(height: 20.0,),
                _botonRetorno()
                ]
              ),
            )
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget _botonRetorno(){
    return StreamBuilder(stream: query2,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        id = snapshot.data.documents[0].documentID;
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: const Color(0xFF4f1bb7),
          onPressed: (){
            List<dynamic> nLibros = [];
            for(dynamic libri in widget.libros) {
              nLibros.add(libri);
            }
            bool repetido = false;
            for(dynamic libri in widget.libros) {
              if(libri['linkPDF'] == libro['linkPDF']) {
                repetido = true;
              }
            }
            if(!repetido) {
              nLibros.add(libro);    
            }
            print(id);
            Firestore.instance.collection('usuarios').document(id).setData(
              {'correo': widget.correo, 'libros': nLibros} 
            );
            //Navigator.of(context).pushNamed(CollectionsPage.id);
          }
        );
      }
    );
  }
}