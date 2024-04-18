import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckboxProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  bool _isCheckedSuns = false;
  bool _isCheckedOwls = false;
  bool _isCheckedFrogs = false;

  List<bool> getCurrentCheckboxValues() {
    return [_isCheckedSuns, _isCheckedOwls, _isCheckedFrogs];
  }

  CheckboxProvider() {
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
//load state of checkbox and set them
    _isCheckedSuns = _prefs.getBool('isCheckedSuns') ?? false;
    _isCheckedOwls = _prefs.getBool('isCheckedOwls') ?? false;
    _isCheckedFrogs = _prefs.getBool('isCheckedFrogs') ?? false;
    notifyListeners();
  }

  bool get isCheckedSuns => _isCheckedSuns;
  bool get isCheckedOwls => _isCheckedOwls;
  bool get isCheckedFrogs => _isCheckedFrogs;

  void toggleCBSuns() async {
    _isCheckedSuns = !_isCheckedSuns;
    notifyListeners();
    await _prefs.setBool('isCheckedSuns', _isCheckedSuns);
//save information about switched checkbox of suns
  }

  void toggleCBOwls() async {
    _isCheckedOwls = !_isCheckedOwls;
    notifyListeners();
    await _prefs.setBool('isCheckedOwls', _isCheckedOwls);
//save information about switched checkbox of owls
  }

  void toggleCBFrogs() async {
    _isCheckedFrogs = !_isCheckedFrogs;
    notifyListeners();
    await _prefs.setBool('isCheckedFrogs', _isCheckedFrogs);
//save information about switched checkbox of frogs
  }
}
