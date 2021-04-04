import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

import 'app.dart';
import 'utils/layout_indicator_bar.dart';
import 'utils/media_query_window.dart';

/// Mac Pixel Resolution 2880 x 1800
/// Device Pixel Ratio
void main() {
  runApp(DashboardApp());
}


/// Primera Parte Demo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DevicePixelRatio(
      //devicePixelRatio: 1,
      child: Layout(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) {
            Widget widget = child!;
            widget = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: widget),
                LayoutBar(),
              ],
            );

            return Layout(child: widget);
          },
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final margin = LayoutValue<double>.fromBreakpoint(xs: 12, md: 16, xl: 32);

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Gutter(),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          Gutter(),
          if (context.breakpoint < LayoutBreakpoint.md)
            Padding(
              padding: EdgeInsets.all(margin.resolve(context)),
              child: Text(
                'Device Pixel Ratio: ' +
                    MediaQuery.of(context)
                        .devicePixelRatio
                        .toString(), //+ MediaQuery.of(context).devicePixelRatio.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          Gutter(),

          Expanded(
            child: ListView(
              children: [
                for (final int i in List.generate(200, (index) => index))
                  FluidMargin(
                    child: Text('Item $i'),
                  ),
              ],
            ),
          ),
          //if(false)
          /* Text(
            'LayoutBreakpoint: ' + context.breakpoint.toString(),
          ),
          Expanded(
            child: FluidMargin(
              child: Container(
                color: Colors.red,
                child: ListView(
                  children: [
                    for (final i in List.generate(200, (i) => i)) ...[
                      Text('Item $i'),
                      Gutter(20)
                    ],
                  ],
                ),
              ),
            ),
          ), */
        ],
      ),

      floatingActionButton: FloatingActionButton(
        mini: context.breakpoint < LayoutBreakpoint.md,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
