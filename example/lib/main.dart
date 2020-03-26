import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_screen/multi_screen.dart';

void main() => runApp(
      MaterialApp(
        title: 'Multi Screen',
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
            title: Text('Multi Screen example'),
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
                  child: Text('Multi screen methods example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiScreenMethodsScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multi screen scaffold example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiScreenScaffoldScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multi screen scaffold using body example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiScreenScaffoldBodyScreen(),
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
    MultiScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MultiScreenScaffold(
        appSpanned: _isAppSpannedStream,
        left: Scaffold(
          appBar: AppBar(
            title: Text('Multi Screen drag and drop example'),
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

class MultiScreenMethodsScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultiScreenMethodsScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MultiScreenMethodsScreenState createState() =>
      _MultiScreenMethodsScreenState();
}

class _MultiScreenMethodsScreenState extends State<MultiScreenMethodsScreen> {
  bool _isMultiScreenDevice;
  bool _isAppSpanned;
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultiScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  Future<void> _updateMultiScreenInfo() async {
    bool isMultiDevice = await MultiScreenMethods.isMultiScreenDevice;
    bool isAppSpanned = await MultiScreenMethods.isAppSpanned;

    if (!mounted) return;

    setState(() {
      _isMultiScreenDevice = isMultiDevice;
      _isAppSpanned = isAppSpanned;
    });
  }

  @override
  Widget build(BuildContext context) => MultiScreenScaffold(
        appSpanned: _isAppSpannedStream,
        appBar: AppBar(
          title: Text('Multi Screen example'),
        ),
        left: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Multi device: ${_isMultiScreenDevice ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('App spanned: ${_isAppSpanned ?? 'Unknown'}'),
              SizedBox(height: 8),
              RaisedButton(
                child: Text('Manually determine multi device and app spanned'),
                onPressed: () => _updateMultiScreenInfo(),
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

class MultiScreenScaffoldScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultiScreenScaffoldScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MultiScreenScaffoldScreenState createState() =>
      _MultiScreenScaffoldScreenState();
}

class _MultiScreenScaffoldScreenState extends State<MultiScreenScaffoldScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultiScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MultiScreenScaffold(
        appSpanned: _isAppSpannedStream,
        left: MultiScreenScaffoldScreenNavigationExampleFirstScreen(),
        right: MultiScreenScaffoldScreenNavigationExampleSecondScreen(),
      );
}

class MultiScreenScaffoldScreenNavigationExampleFirstScreen
    extends StatefulWidget {
  @override
  _MultiScreenScaffoldScreenNavigationExampleFirstScreenState createState() =>
      _MultiScreenScaffoldScreenNavigationExampleFirstScreenState();
}

class _MultiScreenScaffoldScreenNavigationExampleFirstScreenState
    extends State<MultiScreenScaffoldScreenNavigationExampleFirstScreen> {
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

class MultiScreenScaffoldScreenNavigationExampleSecondScreen
    extends StatefulWidget {
  @override
  _MultiScreenScaffoldScreenNavigationExampleSecondScreenState createState() =>
      _MultiScreenScaffoldScreenNavigationExampleSecondScreenState();
}

class _MultiScreenScaffoldScreenNavigationExampleSecondScreenState
    extends State<MultiScreenScaffoldScreenNavigationExampleSecondScreen> {
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

class MultiScreenScaffoldBodyScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MultiScreenScaffoldBodyScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);
  @override
  _MultiScreenScaffoldBodyScreenState createState() =>
      _MultiScreenScaffoldBodyScreenState();
}

class _MultiScreenScaffoldBodyScreenState
    extends State<MultiScreenScaffoldBodyScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MultiScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiScreenScaffold(
      appSpanned: _isAppSpannedStream,
      appBar: AppBar(
        title: Text('Multi Screen scaffold using body example'),
      ),
      body: Center(
        child: Text('Example text'),
      ),
    );
  }
}
