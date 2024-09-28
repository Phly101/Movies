import 'package:flutter/material.dart';

class GenreProvider extends ChangeNotifier{
  String? genreID;
  num? iD;

  void setGenreId(String genreId,num id) {
    genreID = genreId;
    iD =id;

    notifyListeners();
  }
  String? fetchGenreName(){
    if(genreID!=null){
      return genreID;
    }
    return null;

  }
  num? fetchGenreId(){
    if(iD!=null){
      return iD;
    }
    return null;

  }


}