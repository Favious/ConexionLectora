import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(new MaterialApp(
      title: "Conexión lectora",
      theme: new ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        backgroundColor: Colors.white,
      ),
      home: new Scaffold(
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
                    color: Colors.blue,
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
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )));
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
            onPressed: () {},
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
                  style: new TextStyle(color: Colors.black),
                ),
                Text(
                  bookCantity.toString(),
                  style: new TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}


// ViewBookList

class ViewBookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booklist',
      home: Body(title: 'Flutter Demo Home Page'),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            new BookDescriptionButton(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIYQMj6_wAxR3S4-2YIdKhdTwMEpVNU4ToNA&usqp=CAU',
                'to kill a moking bird',
                'i dont know',
                10),
          ],
        ),
      ),
    );
  }
}

class BookDescriptionButton extends StatelessWidget {
  final String coverPagePath;
  final String bookName;
  final String authorName;
  final int percent;

  const BookDescriptionButton(
      this.coverPagePath, this.bookName, this.authorName, this.percent);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: new SizedBox(
          height: 60,
          child: new TextButton(
            onPressed: () {},
            style: new ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
            ),
            child: new Row(
              children: [
                CoverPage(coverPagePath),
                SizedBox(
                  width: 20,
                ),
                new Flexible(
                  child: BookInfo(bookName, authorName, percent),
                  flex: 1,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("$percent%"),
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
        Text(bookName),
        Text(authorName),
        SizedBox(
          height: 5,
          width: double.infinity,
          child: LinearProgressIndicator(
            value: percent / 100,
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
      child: new Image.network(
        path,
        height: 60,
      ),
    );
  }
}
