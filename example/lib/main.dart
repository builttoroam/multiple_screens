import 'package:flutter/material.dart';
import 'dart:async';

import 'package:dual_screen/dual_screen.dart';

void main() => runApp(
      MaterialApp(
        title: 'Dual Screen',
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
            title: Text('Dual Screen example'),
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
                  child: Text('Dual screen methods example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DualScreenMethodsScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Dual screen scaffold example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DualScreenScaffoldScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Dual screen scaffold using body example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DualScreenScaffoldBodyScreen(),
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
    DualScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => DualScreenScaffold(
        appSpanned: _isAppSpannedStream,
        left: Scaffold(
          appBar: AppBar(
            title: Text('Dual Screen drag and drop example'),
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

class DualScreenMethodsScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const DualScreenMethodsScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _DualScreenMethodsScreenState createState() =>
      _DualScreenMethodsScreenState();
}

class _DualScreenMethodsScreenState extends State<DualScreenMethodsScreen> {
  bool _isDualScreenDevice;
  bool _isAppSpanned;
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    DualScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  Future<void> _updateDualScreenInfo() async {
    bool isDualDevice = await DualScreenMethods.isDualScreenDevice;
    bool isAppSpanned = await DualScreenMethods.isAppSpanned;

    if (!mounted) return;

    setState(() {
      _isDualScreenDevice = isDualDevice;
      _isAppSpanned = isAppSpanned;
    });
  }

  @override
  Widget build(BuildContext context) => DualScreenScaffold(
        appSpanned: _isAppSpannedStream,
        appBar: AppBar(
          title: Text('Dual Screen example'),
        ),
        left: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dual device: ${_isDualScreenDevice ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('App spanned: ${_isAppSpanned ?? 'Unknown'}'),
              SizedBox(height: 8),
              RaisedButton(
                child: Text('Manually determine dual device and app spanned'),
                onPressed: () => _updateDualScreenInfo(),
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

class DualScreenScaffoldScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const DualScreenScaffoldScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _DualScreenScaffoldScreenState createState() =>
      _DualScreenScaffoldScreenState();
}

class _DualScreenScaffoldScreenState extends State<DualScreenScaffoldScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    DualScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => DualScreenScaffold(
        appSpanned: _isAppSpannedStream,
        left: DualScreenScaffoldScreenNavigationExampleFirstScreen(),
        right: DualScreenScaffoldScreenNavigationExampleSecondScreen(),
      );
}

class DualScreenScaffoldScreenNavigationExampleFirstScreen
    extends StatefulWidget {
  @override
  _DualScreenScaffoldScreenNavigationExampleFirstScreenState createState() =>
      _DualScreenScaffoldScreenNavigationExampleFirstScreenState();
}

class _DualScreenScaffoldScreenNavigationExampleFirstScreenState
    extends State<DualScreenScaffoldScreenNavigationExampleFirstScreen> {
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

class DualScreenScaffoldScreenNavigationExampleSecondScreen
    extends StatefulWidget {
  @override
  _DualScreenScaffoldScreenNavigationExampleSecondScreenState createState() =>
      _DualScreenScaffoldScreenNavigationExampleSecondScreenState();
}

class _DualScreenScaffoldScreenNavigationExampleSecondScreenState
    extends State<DualScreenScaffoldScreenNavigationExampleSecondScreen> {
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

class DualScreenScaffoldBodyScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const DualScreenScaffoldBodyScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);
  @override
  _DualScreenScaffoldBodyScreenState createState() =>
      _DualScreenScaffoldBodyScreenState();
}

class _DualScreenScaffoldBodyScreenState
    extends State<DualScreenScaffoldBodyScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    DualScreenMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DualScreenScaffold(
      appSpanned: _isAppSpannedStream,
      appBar: AppBar(
        title: Text('Dual Screen scaffold using body example'),
      ),
      body: Center(
        child: Text('Example text'),
      ),
    );
  }
}
