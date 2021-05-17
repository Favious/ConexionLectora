
import 'package:flutter/material.dart';

class LoginPage  extends StatefulWidget {
 static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage > {
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
            child: Text('Iniciar Sesion'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Colors.blueAccent[100],
          onPressed: (){}
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
            child: Text('Registrarse'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Colors.blueAccent[100],
          onPressed: (){}
        );
      }
    );
  }
}
