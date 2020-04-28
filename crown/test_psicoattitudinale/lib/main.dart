import 'package:flutter/material.dart';
import 'ui/first_screen.dart';
import 'ui/second_screen.dart';
import 'bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drag and Drop Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag&Drop Game'),
      ),
      body: StreamBuilder(
        stream: bloc.streamScreen,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data)
              return FirstScreen(bloc);
            else
              return SecondScreen(bloc);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return FirstScreen(bloc);
        }
      ),
    );
  }

}