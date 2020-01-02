import 'package:flutter/material.dart';
import 'dart:async';

import 'counter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterBloc bloc = CounterBloc();

  @override
  void dispose(){
    super.dispose();
    bloc.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stream version of the Counter App')),
        body: Center(
          //Streambuild takes a stream, initial state, and a builder that does the rebuilding when a new
          // item enters the stream
          child: StreamBuilder<int>(
              stream: bloc.stateStream,
              initialData: bloc.item,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                return Text('You hit me: ${snapshot.data} times');
              }
          ),
        ),
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            bloc.eventSink.add(IncrementEvent());
          },
        ),FloatingActionButton(
          child: const Icon(Icons.remove),
          onPressed: (){
            bloc.eventSink.add(DecrementEvent());
          },
        ),
        ],
        )
    );
  }
}

