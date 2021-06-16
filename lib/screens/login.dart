import 'package:flutter/material.dart';
import 'collections.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage  extends StatefulWidget {
 static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage > {
  String correo="";
  String contrase="";
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
              _userTextField(),
              SizedBox(height: 15,),
              _passwordFied(),
              SizedBox(height: 20.0,),
              _bottonLogin(),
              SizedBox(height: 20.0,),
              _bottonRegistrarse(),
            ],
          ),
        ),
       ),
      );
  }

  Widget _userTextField(){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ejemplo@gmail.com',
              labelText: 'Correo Electronico',
            ),
            onChanged: (value){
              correo=value;

            },
          ) ,
        );
      }
    );
  }
  Widget _passwordFied(){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
           keyboardType: TextInputType.emailAddress,
           obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
            ),
            onChanged: (value){
              contrase=value;

            },
          ) ,
        );
      }
    );
  }
  Widget _bottonLogin(){
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Iniciar Sesion',
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
            signedIn(context);
            //Navigator.of(context).pushNamed(CollectionsPage.id);
          }
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
            Navigator.of(context).pushNamed(RegisterPage.id);
          }
        );
      }
    );
  }
  void _showAlertDialogCorreo(mensaje) {
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
  
  void _showAlertDialogContras() {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Ocurrio un error"),
          content: Text("la contraseña es incorrecta"),
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
  AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: correo,
    password: contrase
  );
  Navigator.of(context).pushNamed(CollectionsPage.id);
  //print('valido la cuenta');
  //print(user.toString());
  }catch (e) {
    print(e.code);
  if (e.code == 'ERROR_USER_NOT_FOUND') {
    _showAlertDialogCorreo("no se encontro el correo");
  } else if (e.code == 'ERROR_INVALID_EMAIL') {
    _showAlertDialogCorreo("el correo es invalido");
  } else if (e.code == 'ERROR_WRONG_PASSWORD') {
    _showAlertDialogContras();
  } else if (e.code == 'error'){
    _showAlertDialogCorreo("Los campos no deben ser vacios");


  }
  //print('no inicio sesion');
  print(e.code);
  }
}
}

