import 'package:flutter/material.dart';

class DetailsScreenProvider extends ChangeNotifier {
  num? iD;

  void setDetailsScreenId(num? id) {
    iD = id;
    notifyListeners();
  }

  num? fetchDetailsScreenId() {
    if (iD != null) {
      return iD;
    }
    return null;
  }
}
