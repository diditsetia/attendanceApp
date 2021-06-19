import 'package:shared_preferences/shared_preferences.dart';

Future<String> getName() async {
  final _p = await SharedPreferences.getInstance();
  return _p.getString('name');
}

Future<void> setName(String name) async {
  final _p = await SharedPreferences.getInstance();
  await _p.setString('username', name);
}
