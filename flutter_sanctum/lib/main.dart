import 'package:flutter/material.dart';
import 'package:flutter_sanctum/providers/auth.dart';
import 'package:flutter_sanctum/widgets/nav-drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Auth(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Sanctum'),
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
  final storage = new FlutterSecureStorage();

  void _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');
    Provider.of<Auth>(context, listen: false).attempt(key);
  }

  @override
  void initState() {
    _attemptAuthentication();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (auth.authenticated) {
              return Text('You are logged in!');
            } else {
              return Text('You are not logged in!');
            }
          },
        )
      ),
    );
  }
}
