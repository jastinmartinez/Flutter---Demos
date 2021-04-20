import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureBuilderSnapshot) {
        if (futureBuilderSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, streamBuilderSnapshot) {
            if (streamBuilderSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamBuilderSnapshot.data.documents;

            return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                  documents[index]['text'],
                  documents[index]['userId'] == futureBuilderSnapshot.data.uid,
                  documents[index]['username'],
                  documents[index]['userimage'],
                  documents[index]['createdAt'],
                  key: ValueKey(documents[index].documentID),
                );
              },
              itemCount: documents.length,
            );
          },
        );
      },
    );
  }
}
