import 'package:firebase2/ui/auth/login_screen.dart';
import 'package:firebase2/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('feed'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen() ));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });



          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
