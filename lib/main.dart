import 'package:flutter/material.dart';
import 'package:untitled22/contactscreen.dart';
 
void main (){
  runApp(MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp( debugShowCheckedModeBanner: false,
       home: ContactScreen(),
     );
   }
 }
 
