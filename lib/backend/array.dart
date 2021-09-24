import 'dart:math';
import './tile.dart';
import './getLocal.dart';
import 'dart:convert';

class ArrayTile {
  final int w, h;
  List? array;
  bool ismove = false;
  int _score = 0;
  Local local = Local();
  get score => _score;
  get highscore => local.highscore;
  Random _random = Random();
  ArrayTile(this.w, this.h) {
    if (array == null) {
      reset();
    }
  }
  factory ArrayTile.fromjson(int w, int h, int score, int highscore, List grid) {
    List narray = grid.map((row) => row.map((value) => Tile(value)).toList()).toList();
    return ArrayTile(w, h)
      .._score = score
      ..local.highscore = highscore
      ..array = narray;
  }
  void addScore() {
    List? flatlist = array?.expand((value) => value).toList();
    final mergelist = flatlist?.where((tile) => tile.merge == true).toList();
    if (mergelist!.isNotEmpty) {
      final int points = mergelist.length == 1 ? mergelist.first.value : mergelist.map((tile) => tile.value).reduce((total, value) => total + value).toInt();
      _score += points;
    }
    local.setlocal_score(_score);
    if (_score > local.highscore) {
      local.setHighscore(_score);
    }
  }

  operator [](int index) {
    return array?[index];
  }

  void addgrid() {
    List? grid = array?.map((row) => row.map((obj) => obj.value).toList()).toList();
    print(grid);
    local.setlocal_value(json.encode(grid!));
  }

  void reset() {
    array = [];
    for (int x = 0; x < h; x++) {
      array?.add([]);
      for (int y = 0; y < w; y++) {
        array?[x].add(Tile(0));
      }
    }
    _score = 0;
    local.setlocal_score(_score);
    addNew();
    addNew();
    addgrid();
  }

  List empty() {
    List empty = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (array?[i][j].value == 0) {
          empty.add(Pos(i, j));
        }
      }
    }
    return empty;
  }

  void addNew() {
    List ety = empty();
    Pos n_tile = ety[_random.nextInt(ety.length)];
    final n_value = _random.nextInt(10) == 0 ? 4 : 2;
    addTile(n_tile.x, n_tile.y, Tile(n_value, isnew: true));
  }

  void addTile(x, y, Tile tile) {
    array?[x][y] = tile;
  }

  void swipe(String direction) {
    ismove = false;
    array = array?.map((row) => row.map((obj) => Tile(obj.value)).toList()).toList();
    Vector vector = Vector.fromDirection(direction);
    Order order = Order.formDirection(direction, w, h);
    bool isincrease_row = order.frow < order.lrow;
    bool isincrease_col = order.fcol < order.lcol;
    for (int i = order.frow; isincrease_row ? i < order.lrow : i > order.lrow; isincrease_row ? i++ : i--) {
      for (int j = order.fcol; isincrease_col ? j < order.lcol : j > order.lcol; isincrease_col ? j++ : j--) {
        swipSingle(i, j, vector);
      }
    }
    if (ismove == true) {
      addNew();
      addScore();
      addgrid();
    }
  }

  void swipSingle(int x, int y, Vector vector) {
    int count = 0;
    int nx = x - vector.x;
    int ny = y - vector.y;
    int value = 1;
    while (true) {
      nx += vector.x;
      ny += vector.y;
      if (nx < 0 || nx > 3) break;
      if (ny < 0 || ny > 3) break;
      if (count == 1) {
        if (array?[nx][ny].value != 0) {
          if (array?[nx][ny].value == value) {
            array?[nx][ny] = Tile(0);
            array?[x][y] = Tile(value * 2, merge: true);
            ismove = true;
          }
          break;
        }
      } else {
        if (array?[nx][ny].value != 0) {
          count++;
          value = array?[nx][ny].value;
          if (x != nx || y != ny) {
            array?[nx][ny] = Tile(0);
            array?[x][y] = Tile(value);
            ismove = true;
          }
        }
      }
    }
  }

  bool blocked() {
    List? vArray = array?.map((row) => row.map((obj) => obj.value).toList()).toList();
    //var canSwipUpDown = //vArray?.map((n) => print(n)); //row[vArray.indexOf(n)])); //any((row) => checkAdjacentDuplicate(row)) ?? false;
    //print(canSwipUpDown);
    print(vArray);
    bool havespace = vArray?.expand((row) => row).contains(0) ?? false;
    if (havespace) return false;
    bool canSwipLeftRight = vArray?.any((row) => checkAdjacentDuplicate(row)) ?? false;
    if (canSwipLeftRight) return false;

    //if (canSwipUpDown) return false;
    return true;
  }

  bool checkAdjacentDuplicate(Iterable mylist) {
    int val = 0;
    if (mylist.length > 1)
      for (int a in mylist) {
        if (a == val) {
          return true;
        }
        val = a;
      }
    return false;
  }
}
