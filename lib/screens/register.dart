import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class RegisterPage  extends StatefulWidget {
 static String id = 'register_page';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage > {
  String correo="";
  String contras1="";
  String contras2="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                 child: Image.asset('assets/conexion.png',
                 height: 250.0,
                 ),
              ),
              SizedBox(height: 15.0,),
              _inputFieldCorreo('ejemplo@gmail.com', 'Ingrese su correo electronico'),
              SizedBox(height: 15,),
              _inputFieldContra('Contraseña', 'Ingrese una contraseña'),
              SizedBox(height: 15,),
              _inputFieldContra2('Contraseña', 'Confirme contraseña'),
              SizedBox(height: 20.0,),
              _bottonRegistrarse(),
            ],
          ),
        ),
       ),
      );
  }
  Widget _inputFieldCorreo(String hint, String label){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
            ),
            onChanged: (value){
              correo= value;

            },
          ) ,
        );
      }
    );
  }
  Widget _inputFieldContra(String hint, String label){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
            ),
            onChanged: (value){
              contras1= value;

            },
          ) ,
        );
      }
    );
  }
  Widget _inputFieldContra2(String hint, String label){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
            ),
            onChanged: (value){
              contras2= value;

            },
          ) ,
        );
      }
    );
  }
  Widget _bottonRegistrarse(){
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 88.0, vertical: 15.0),
            child: Text(
              'Registrarse',
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
            //print(correo+contras);
            signedIn(context);
            
          }
        );
      }
    );
  }

  void _showAlertDialogCorreo() {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Ocurrio un error"),
          content: Text("el correo electronico ya esta en uso"),
          actions: <Widget>[
            RaisedButton(
              child: Text("CERRAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      }
    );
  }

  void _showAlertDialogContras(mensaje) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Ocurrio un error"),
          content: Text(mensaje),
          actions: <Widget>[
            RaisedButton(
              child: Text("CERRAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      }
    );
  }
  Future<void> signedIn(context) async {
  try {
    //print(correo+contras);
    if(correo.endsWith("@gmail.com")){
      if(contras1==contras2){
       AuthResult user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correo, password: contras2
         );
         agregarUsuario();
         Navigator.of(context).pushNamed(LoginPage.id); 
      }else{
      _showAlertDialogContras("las contraseñas no son iguales");

      }
    }else{
      _showAlertDialogContras("el correo no es valido");
      
    }
    //print(correo+contras);


  
  
  //print(user.toString());
  }catch (e) {
  if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
    _showAlertDialogCorreo();
    //print('No user found for that email.');
  } else if (e.code == 'error') {
    _showAlertDialogContras("los campos no debe ser vacios");
    //print('Wrong password provided for that user.');
  } else if (e.code== 'ERROR_WEAK_PASSWORD'){
    _showAlertDialogContras("la contraseña es debil");
  }
  print(e.code);
  }
}
void agregarUsuario(){
  print("agregarUsuario");
  
  Firestore.instance.collection("usuarios").add(
  {
    "correo" : correo,
    "libros" : [
      
    ]
  }).then((value){
    //print(value.id);
  });
}
}
