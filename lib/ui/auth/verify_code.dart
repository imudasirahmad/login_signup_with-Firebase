import 'package:firebase2/ui/posts/postscreen.dart';
import 'package:firebase2/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId ;
  const VerifyCodeScreen({Key? key , required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verifyCodeController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        child: Column(
          children: [

            SizedBox(height: 150,),
            TextFormField(
              controller: verifyCodeController,

              decoration: InputDecoration(
                  hintText: '6 Digit Code'
              ),

            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Verify', loading: loading, onTap: ()async {

              setState(() {
                loading = true;
              });

              final credential  = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyCodeController.text.toString());

              try{
                await _auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));

              }
              catch(e){

                setState(() {
                  loading = false;
                });

                Utils().toastMessage(e.toString());

              }




            }),
          ],
        ),
      ),
    );
  }
}
