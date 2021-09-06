import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String high_score = 'highscore';
const String local_grid = 'Local_grid';

class HighScore {
  int value = 0;
  SharedPreferences? _pref;
  HighScore(this.value);
  initpref() async {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
  }

  void setHighscore(int val) async {
    value = val;
    await initpref();
    _pref?.setInt(high_score, value);
  }

  void setlocal_value(String grid) async {
    await initpref();
    _pref?.setString(local_grid, grid);
  }
}

Future<int> getHighscore() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  int value = await _pref.getInt(high_score) ?? 0;
  return value;
}

Future<List?> getLocalGrid() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String? string_grid = await _pref.getString(local_grid);
  print(string_grid);
  if (string_grid == null) {
    return null;
  }
  List? grid = json.decode(string_grid)?.toList();

  return grid;
}
