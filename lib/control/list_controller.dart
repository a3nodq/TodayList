import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ListController extends GetxController {
  List item = [].obs;
  var textAddController = TextEditingController();

  void addItem(value){
    item.add(value);
  }
  void deleteItem(index){
    item.removeAt(index);
  }

  void editItem(index,value){
    item[index] = value;

  }
}