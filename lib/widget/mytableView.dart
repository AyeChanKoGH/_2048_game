import 'package:flutter/material.dart';
import 'package:_2048/backend/array.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:flutter/services.dart';
import './emptyContainer.dart';
import './color.dart';
import './newView.dart';
import './mergeview.dart';
import './find_size.dart';
import './valueContainer.dart';
import '../backend/getLocal.dart';
import './gameOver.dart';

class MyTableView extends StatefulWidget {
  @override
  MyTableViewState createState() => MyTableViewState();
}

class MyTableViewState extends State<MyTableView> {
  static const w = 4;
  static const h = 4; //w=width ,h=height
  ArrayTile? _board;
  bool isgameOver = false;
  bool isinitilize = false;
  @override
  void initState() {
    _board = ArrayTile(w, h);
    getLocal();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void getLocal() async {
    int highscore = await getHighscore();
    int score = await getScore();
    List? grid = await getLocalGrid();
    setState(() {
      if (grid == null) {
        _board = ArrayTile(w, h);
      } else {
        _board = ArrayTile.fromjson(w, h, score, highscore, grid!);
        isgameOver = _board?.blocked() ?? false;
      }
      isinitilize = true;
    });
  }

  void reset() {
    setState(() {
      _board?.reset();
      isgameOver = false;
    });
  }

  void swipe(String direction) {
    setState(() {
      _board?.swipe(direction);
      isgameOver = _board?.blocked() ?? false;
      //isgameOver = true;
    });
  }

  void _onVerticalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.up) {
        swipe('Up');
      } else {
        swipe('Down');
      }
    });
  }

  void _onHorizontalSwipe(SwipeDirection direction) {
    setState(() {
      if (direction == SwipeDirection.left) {
        swipe('Left');
      } else {
        swipe('Right');
      }
    });
  }

  Widget build(BuildContext context) {
    if (!isinitilize) {
      return CircularProgressIndicator();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        buildScoreView(),
        Spacer(),
        AspectRatio(
          aspectRatio: 1.0,
          child: Stack(children: <Widget>[
            SimpleGestureDetector(
              onVerticalSwipe: _onVerticalSwipe,
              onHorizontalSwipe: _onHorizontalSwipe,
              swipeConfig: const SimpleSwipeConfig(
                verticalThreshold: 40.0,
                horizontalThreshold: 40.0,
                swipeDetectionBehavior: SwipeDetectionBehavior.singularOnEnd,
              ),
              child: Container(
                color: colormatch['background'],
                child: Table(
                  children: _getTableRow(),
                ),
              ),
            ),
            isgameOver ? GameOver() : Container(),
            //GameOver(),
          ]),
        ),
        Spacer(),
        ElevatedButton(
          child: Text('New Game', style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlueAccent[200],
            minimumSize: Size(200, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () {
            reset();
          },
        ),
        Spacer(),
      ],
    );
  }

  List<TableRow> _getTableRow() {
    return List.generate(h, (row) => TableRow(children: _getrow(row)));
  }

  List<Widget> _getrow(int row) {
    return List.generate(w, (col) => buildContainer(row, col));
  }

  Widget buildScoreView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 40,
                color: Colors.amberAccent,
                child: const Text('Score'),
                alignment: Alignment.center,
              ),
              Container(
                width: 70,
                height: 40,
                color: Colors.cyanAccent,
                child: Text('${_board?.score}'),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        Card(
            margin: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Container(
                height: 40,
                width: 70,
                color: Colors.amberAccent,
                child: const Text('Best'),
                alignment: Alignment.center,
              ),
              Container(
                height: 40,
                width: 70,
                color: Colors.cyanAccent,
                child: Text('${_board?.highscore}'),
                alignment: Alignment.center,
              ),
            ])),
      ],
    );
  }

  Widget buildContainer(int row, int col) {
    final tile = _board?[row][col];
    final mergin = 5.0;
    final _height = getchildheight(context, w, mergin);
    return Container(
      margin: EdgeInsets.all(mergin),
      height: _height,
      child: tile == null
          ? null
          : tile.isnew
              ? NewView(tile.value)
              : tile.merge
                  ? MegerdView(tile.value)
                  : tile.value != 0
                      ? ValueContainer(tile.value)
                      : EmptyContainer(),
    );
  }
}
