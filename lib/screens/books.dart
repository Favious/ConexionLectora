import 'package:flutter/material.dart';

class ViewBookList extends StatefulWidget {
  static String id = 'books_page';
  @override
  _ViewBookListState createState() => _ViewBookListState();
}

class _ViewBookListState extends State<ViewBookList>  {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Libros"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            BookDescriptionButton(
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
        child: SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {},
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
        Text(authorName,
          style: TextStyle(
            color: Colors.grey
          )
        ),
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
      child: Image.network(
        path,
        height: 60,
      ),
    );
  }
}