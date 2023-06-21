import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser() async{
  List user = [];

  QuerySnapshot querySnapshot = await db.collection('user').get();
  for (var doc in querySnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "uid":doc.id,
    };

    user.add(person);
  }
  return user;
}


//guardar en base de datos
Future<void> addUser(String name) async{
  await db.collection('user').add({'name': name });
}

//Actualizar un nombre en la base de datos

Future<void> updateUser(String uid, String newName)async{
  await db.collection('user').doc(uid).set({'name': newName});
}

//Eliminar datos de la base datos 

Future<void> deleteUser(String uid)async{
  await db.collection('user').doc(uid).delete();
}