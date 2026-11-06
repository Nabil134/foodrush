import 'package:flutter/material.dart';

class SnackBarUtils{
static void showMessage(BuildContext context, String message,{bool isError=false}){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: isError?Colors.red:Colors.green,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    content: Text(message,style:const TextStyle(color: Colors.white),),),);
}
}