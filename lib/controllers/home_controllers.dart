import 'package:shared_preferences/shared_preferences.dart';

class HomeControllers {

  late final SharedPreferences _pref; 

  Future<void> init() async{
    _pref = await SharedPreferences.getInstance(); 
  }

  Future<void> setBestScore(int score) async {
    await _pref.setInt('bestScore', score);
  }

  Future<int> getBestScore() async {
    return _pref.getInt('bestScore') ?? 0;
  }

}