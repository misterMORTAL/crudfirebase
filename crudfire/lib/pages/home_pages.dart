// ignore_for_file: prefer_const_constructors

import 'package:crudfire/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud con firebase, GUARDAR, EDITAR, ELIMINAR'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: ((context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                return  Dismissible(
                  onDismissed: (direction)async{
                    await deleteUser(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction)async{
                    bool result = false;

                    result = await showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('¿Quieres eliminar este elemento ${snapshot.data?[index]['name']}?'),
                        actions: [
                          TextButton(onPressed: (){
                            return Navigator.pop(
                              context,
                              false,
                            );
                          },
                          child: const Text('Cancelar',
                          style:TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),

                          TextButton(onPressed: (){
                            return Navigator.pop(
                              context,
                              true,
                            );
                          },
                          child: const Text('Aceptar',
                          style:TextStyle(color: Color.fromARGB(255, 0, 0, 0))))
                        ],
                      );
                    });
                    return result;
                  },
                  background: Container(
                    color: Color.fromARGB(255, 255, 0, 0),
                    child: Icon(Icons.delete),
                  ),
                  direction: DismissDirection.startToEnd,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async{
                      await Navigator.pushNamed(context, '/edit',
                          arguments:{
                            "name": snapshot.data?[index]['name'],
                            "uid": snapshot.data?[index]['uid'],
                          });
                      setState(() {});
                    }),
                  ),
                );
              },
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
        })),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await Navigator.pushNamed(context, '/add');
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        
    );
  }
}