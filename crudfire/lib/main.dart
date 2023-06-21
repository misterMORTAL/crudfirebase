import 'package:crudfire/pages/add_name_page.dart';
import 'package:crudfire/pages/edit_name_pages.dart';
import 'package:crudfire/pages/home_pages.dart';
import 'package:flutter/material.dart';

//importaciones de FireBase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp  extends StatelessWidget{
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD FIREBASE',
      initialRoute: '/',
      routes: {
        '/': (context)=> const Home(),
        '/add': (context)=> const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
      },
    );
  }
  
}

