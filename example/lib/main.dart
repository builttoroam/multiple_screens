import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multiple_screens/multiple_screens.dart';

void main() => runApp(
      MaterialApp(
        title: 'Mutiple Screens',
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
            title: Text('Mutiple Screens example'),
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
                      builder: (context) => MutipleScreensMethodsScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multi screen scaffold example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MutipleScreensScaffoldScreen(),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Multi screen scaffold using body example'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MutipleScreensScaffoldBodyScreen(),
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
    MutipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MutipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        left: Scaffold(
          appBar: AppBar(
            title: Text('Mutiple Screens drag and drop example'),
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

class MutipleScreensMethodsScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MutipleScreensMethodsScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MutipleScreensMethodsScreenState createState() =>
      _MutipleScreensMethodsScreenState();
}

class _MutipleScreensMethodsScreenState extends State<MutipleScreensMethodsScreen> {
  bool _isMutipleScreensDevice;
  bool _isAppSpanned;
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MutipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  Future<void> _updateMutipleScreensInfo() async {
    bool isMultiDevice = await MutipleScreensMethods.isMutipleScreensDevice;
    bool isAppSpanned = await MutipleScreensMethods.isAppSpanned;

    if (!mounted) return;

  setState(() {
      _isMutipleScreensDevice = isMultiDevice;
      _isAppSpanned = isAppSpanned;
    });
  }

  @override
  Widget build(BuildContext context) => MutipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        appBar: AppBar(
          title: Text('Mutiple Screens example'),
        ),
        left: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Multi device: ${_isMutipleScreensDevice ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('App spanned: ${_isAppSpanned ?? 'Unknown'}'),
              SizedBox(height: 8),
              RaisedButton(
                child: Text('Manually determine multi device and app spanned'),
                onPressed: () => _updateMutipleScreensInfo(),
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

class MutipleScreensScaffoldScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MutipleScreensScaffoldScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);

  @override
  _MutipleScreensScaffoldScreenState createState() =>
      _MutipleScreensScaffoldScreenState();
}

class _MutipleScreensScaffoldScreenState extends State<MutipleScreensScaffoldScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MutipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) => MutipleScreensScaffold(
        appSpanned: _isAppSpannedStream,
        left: MutipleScreensScaffoldScreenNavigationExampleFirstScreen(),
        right: MutipleScreensScaffoldScreenNavigationExampleSecondScreen(),
      );
}

class MutipleScreensScaffoldScreenNavigationExampleFirstScreen
    extends StatefulWidget {
  @override
  _MutipleScreensScaffoldScreenNavigationExampleFirstScreenState createState() =>
      _MutipleScreensScaffoldScreenNavigationExampleFirstScreenState();
}

class _MutipleScreensScaffoldScreenNavigationExampleFirstScreenState
    extends State<MutipleScreensScaffoldScreenNavigationExampleFirstScreen> {
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

class MutipleScreensScaffoldScreenNavigationExampleSecondScreen
    extends StatefulWidget {
  @override
  _MutipleScreensScaffoldScreenNavigationExampleSecondScreenState createState() =>
      _MutipleScreensScaffoldScreenNavigationExampleSecondScreenState();
}

class _MutipleScreensScaffoldScreenNavigationExampleSecondScreenState
    extends State<MutipleScreensScaffoldScreenNavigationExampleSecondScreen> {
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

class MutipleScreensScaffoldBodyScreen extends StatefulWidget {
  final bool isAppSpannedStream;

  const MutipleScreensScaffoldBodyScreen({
    Key key,
    this.isAppSpannedStream,
  }) : super(key: key);
  @override
  _MutipleScreensScaffoldBodyScreenState createState() =>
      _MutipleScreensScaffoldBodyScreenState();
}

class _MutipleScreensScaffoldBodyScreenState
    extends State<MutipleScreensScaffoldBodyScreen> {
  bool _isAppSpannedStream = false;

  @override
  void initState() {
    super.initState();
    MutipleScreensMethods.isAppSpannedStream().listen(
      (data) => setState(() => _isAppSpannedStream = data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MutipleScreensScaffold(
      appSpanned: _isAppSpannedStream,
      appBar: AppBar(
        title: Text('Mutiple Screens scaffold using body example'),
      ),
      body: Center(
        child: Text('Example text'),
      ),
    );
  }
}
