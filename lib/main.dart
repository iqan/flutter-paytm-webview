import 'package:flutter/material.dart';
import 'package:flutter_paytm_webview/payment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PayTM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter PayTM Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Initiate Payment',
              style: TextStyle(fontSize: 28.0),
            ),
            SizedBox(
              height: 28.0,
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'PAY',
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (BuildContext _) => Payment()))
                      .then((_) {
                    setState(() {
                      result = 'Payment Completed';
                    });
                  }),
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              result,
              style: TextStyle(fontSize: 28.0, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
