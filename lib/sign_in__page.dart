import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';
class sign_in_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(T}title: Text("Registrarse")),
      //title: 'Welcome to Flutter',
      //home: Scaffold(
        appBar: AppBar(
          title: Text('Registrarse'),
        ),
        body: Center(
         // child: Text('Hello World'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                 child: Image.asset('images/conexion.png',
                 height: 250.0,
                 ),
              ),
              SizedBox(height: 15.0,),
              _correoTextField(),
              SizedBox(height: 15,),
              _passwordFied(),
              SizedBox(height: 15,),
              _passwordConfirmFied(),
              SizedBox(height: 20.0,),
              _bottonRegistrarse(),
            ],
          ),
        ),    
    );
  }
  
}
 Widget _correoTextField(){
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

  Widget _passwordConfirmFied(){
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapchot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Contraseña',
              labelText: 'Confirmacion de contraseña',
            ),
            onChanged: (value){

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
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrarse'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Colors.blueAccent[100],
          onPressed:(){
            signedIn(context);
          } 
        );
      }
    );
  
}

Future<void> signedIn(context) async {
  try {
  /*AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "test123@gmail.com",
    password: "test123"
  );*/
  AuthResult user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "test12345@gmail.com", password: "test12345"
    );
  //BuildContext context;
  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
  print('valido la cuenta');
  print(user.toString());
  }catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
  print('no se registro');
  }
}