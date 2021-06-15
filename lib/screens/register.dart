import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class RegisterPage  extends StatefulWidget {
 static String id = 'register_page';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage > {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                 child: Image.asset('../assets/conexion.png',
                 height: 250.0,
                 ),
              ),
              SizedBox(height: 15.0,),
              _inputField('ejemplo@gmail.com', 'Ingrese su correo electronico'),
              SizedBox(height: 15,),
              _inputField('Contraseña', 'Ingrese una contraseña'),
              SizedBox(height: 15,),
              _inputField('Contraseña', 'Confirme contraseña'),
              SizedBox(height: 20.0,),
              _bottonRegistrarse(),
            ],
          ),
        ),
       ),
      );
  }
  Widget _inputField(String hint, String label){
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
            signedIn(context);
          }
        );
      }
    );
  }
}
Future<void> signedIn(context) async {
  try {
  /*AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "test123@gmail.com",
    password: "test123"
  );*/
  AuthResult user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "nogalesrafael12@gmail.com", password: "test12345"
    );
  //BuildContext context;
  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_page()));
  Navigator.of(context).pushNamed(LoginPage.id);
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