import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8),
          child: Text('hello'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/9vRpB51mnDl9oOoUmLq5/messages')
              .snapshots()
              .listen((event) {
            event.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
    );
  }
}
