import 'package:bloc_example/Logic/cubit/counter_cubit.dart';
import 'package:bloc_example/constants/enums.dart';
import 'package:bloc_example/logic/cubit/internet_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _firstKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _firstKey,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi)
                  return Text('Wifi');
                else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile)
                  return Text('Mobile');
                else if (state is InternetDisconnected)
                  return Text('Disconnected');
                return CircularProgressIndicator();
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.isIncremented)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Increment'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Drement'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
              },
              builder: (context, state) {
                return Text(
                  '${state.counterValue}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).increment(),
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                new FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: () =>
                      BlocProvider.of<CounterCubit>(context).decrement(),
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: Text(
                'Go to second Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
