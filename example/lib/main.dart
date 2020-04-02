import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multiple_screens/multiple_screens.dart';

void main() => runApp(
      MaterialApp(
        title: 'Multiple Screens',
        home: HomeScreen(),
      ),
    );

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Multiple Screens example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text('Drag drop screen example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DragDropScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multiple screen methods example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleScreensMethodsScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multiple screen scaffold example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleScreensScaffoldScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multiple screen scaffold using body example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleScreensScaffoldBodyScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multiple screen hinge example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleScreensHinge(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MultipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        left: Scaffold(
          appBar: AppBar(
            title: Text('Multiple Screens drag and drop example'),
          ),
          body: Center(
            child: Container(
              width: 100.0,
              height: 100.0,
              child: Draggable(
                data: "32",
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Data",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                ),
                feedback: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Data",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                ),
              ),
            ),
          ),
        ),
        right: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(''),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              child: DragTarget(
                builder: (context, List<int> candidateData, rejectedData) =>
                    Center(
                  child: Text(
                    "Landing",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                onWillAccept: (data) => true,
                onAccept: (data) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text("You dropped some data!"),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}

class MultipleScreensMethodsScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultipleScreensMethodsScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MultipleScreensMethodsScreenState createState() =>
      _MultipleScreensMethodsScreenState();
}

class _MultipleScreensMethodsScreenState
    extends State<MultipleScreensMethodsScreen> {
  bool _isMultipleScreensDevice;
  bool _isAppSpanned;
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  Future<void> _updateMultipleScreensInfo() async {
    bool isMultiDevice = await MultipleScreensMethods.isMultipleScreensDevice;
    bool isAppSpanned = await MultipleScreensMethods.isAppSpanned;

    if (!mounted) return;

    setState(() {
      _isMultipleScreensDevice = isMultiDevice;
      _isAppSpanned = isAppSpanned;
    });
  }

  @override
  Widget build(BuildContext context) => MultipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        appBar: AppBar(
          title: Text('Multiple Screens example'),
        ),
        left: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Multi device: ${_isMultipleScreensDevice ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('App spanned: ${_isAppSpanned ?? 'Unknown'}'),
              SizedBox(height: 8),
              RaisedButton(
                child: Text('Manually determine multi device and app spanned'),
                onPressed: () => _updateMultipleScreensInfo(),
              ),
              SizedBox(height: 64),
              Text(
                'App spanned stream: ${_isAppSpannedStream ?? 'Unknown'}',
              ),
            ],
          ),
        ),
        right: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('second screen'),
            ],
          ),
        ),
      );
}

class MultipleScreensScaffoldScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultipleScreensScaffoldScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MultipleScreensScaffoldScreenState createState() =>
      _MultipleScreensScaffoldScreenState();
}

class _MultipleScreensScaffoldScreenState
    extends State<MultipleScreensScaffoldScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MultipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        left: MultipleScreensScaffoldScreenNavigationExampleFirstScreen(),
        right: MultipleScreensScaffoldScreenNavigationExampleSecondScreen(),
      );
}

class MultipleScreensScaffoldScreenNavigationExampleFirstScreen
    extends StatefulWidget {
  @override
  _MultipleScreensScaffoldScreenNavigationExampleFirstScreenState
      createState() =>
          _MultipleScreensScaffoldScreenNavigationExampleFirstScreenState();
}

class _MultipleScreensScaffoldScreenNavigationExampleFirstScreenState
    extends State<MultipleScreensScaffoldScreenNavigationExampleFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First appbar'),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text('This is the first screen'),
      ),
    );
  }
}

class MultipleScreensScaffoldScreenNavigationExampleSecondScreen
    extends StatefulWidget {
  @override
  _MultipleScreensScaffoldScreenNavigationExampleSecondScreenState
      createState() =>
          _MultipleScreensScaffoldScreenNavigationExampleSecondScreenState();
}

class _MultipleScreensScaffoldScreenNavigationExampleSecondScreenState
    extends State<MultipleScreensScaffoldScreenNavigationExampleSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        title: Text('Second appbar'),
      ),
      body: Center(
        child: Text('This is the second screen'),
      ),
    );
  }
}

class MultipleScreensScaffoldBodyScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultipleScreensScaffoldBodyScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);
  @override
  _MultipleScreensScaffoldBodyScreenState createState() =>
      _MultipleScreensScaffoldBodyScreenState();
}

class _MultipleScreensScaffoldBodyScreenState
    extends State<MultipleScreensScaffoldBodyScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultipleScreensScaffold(
      appSpanned: _isAppSpannedStream,
      appBar: AppBar(
        title: Text('Multiple Screens scaffold using body example'),
      ),
      body: Center(
        child: Text('Example text'),
      ),
    );
  }
}

class MultipleScreensHinge extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultipleScreensHinge({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MultipleScreensHingeState createState() => _MultipleScreensHingeState();
}

class _MultipleScreensHingeState extends State<MultipleScreensHinge> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MultipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        left: MultipleScreensHingeExampleFirstScreen(),
        right: MultipleScreensHingeExampleSecondScreen(),
      );
}

class MultipleScreensHingeExampleFirstScreen extends StatefulWidget {
  @override
  _MultipleScreensHingeExampleFirstScreenState createState() =>
      _MultipleScreensHingeExampleFirstScreenState();
}

class _MultipleScreensHingeExampleFirstScreenState
    extends State<MultipleScreensHingeExampleFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First example'),
      ),
      body: Center(child: Text('Span the app the get hinge angle')),
    );
  }
}

class MultipleScreensHingeExampleSecondScreen extends StatefulWidget {
  @override
  _MultipleScreensHingeExampleSecondScreenState createState() =>
      _MultipleScreensHingeExampleSecondScreenState();
}

class _MultipleScreensHingeExampleSecondScreenState
    extends State<MultipleScreensHingeExampleSecondScreen> {
  Hinge _hinge; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Get hinge'),
              onPressed: () => _getHinge(),
            ),
            SizedBox(height: 8),
            Text('Angle: ${_hinge?.angle}'),
            SizedBox(height: 8),
            Text('Accuracy: ${_hinge?.accuracy}'),
          ],
        ),
      ),
    );
  }

  Future<void> _getHinge() async {
    var hinge = await MultipleScreensMethods.getHinge;

    if (!mounted) return;

    setState(() {
      _hinge = hinge;
    });
  }
}
