import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

enum breath_status { expire, inspire, hold }

class MyHomePageState extends State<MyHomePage> {
  breath_status breathStatus = breath_status.inspire;

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              stops: [0, 0.9],
              colors: [
                Color.fromRGBO(255, 142, 142, 1),
                Color.fromRGBO(255, 247, 220, 1),
              ],
            )),
            child: (Stack(children: [
              Image(
                  image: AssetImage('images/stars.png'), fit: BoxFit.fitWidth),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Center(
                    child: Text(
                      'maintenez',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 200, 200, 1),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: breathStatus == breath_status.expire ? 200 : 400,
                duration: const Duration(seconds: 5),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (breathStatus == breath_status.expire) {
                        breathStatus = breath_status.inspire;
                      } else {
                        breathStatus = breath_status.expire;
                      }
                    });
                  },
                  child: Container(
                    child: Image(
                        image: AssetImage('images/mountains.png'),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: breathStatus == breath_status.expire ? -10 : 800,
                duration: const Duration(seconds: 3),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          breathStatus == breath_status.expire
                              ? 'Expirez'
                              : 'Inspirez',
                          style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 200, 200, 1),
                          ),
                        ),
                      )
                    ]),
              ),
            ]))),
      ),
    );
  }
}
