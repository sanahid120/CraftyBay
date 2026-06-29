import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageMainNavProvider extends ChangeNotifier{
int _selectedIndex = 0;

int get selectedIndex => _selectedIndex;

void updateIndex(int index){
  _selectedIndex = index;
  notifyListeners();
}

void moveToCategory(){
  updateIndex(1);
}
void moveToHomepage(){
  updateIndex(0);
}
}


