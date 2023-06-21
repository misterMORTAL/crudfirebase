import 'package:crudfire/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build (BuildContext context){

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingresar el nuevo nombre'
              ),
            ),
            ElevatedButton(
              onPressed: () async{
              await updateUser(arguments['uid'], nameController.text)
              .then((_) {
                Navigator.pop(context);
              
              });
            },
            child: const Text('Actualizar'))
          ],
        )
      ),
    );
  }
}