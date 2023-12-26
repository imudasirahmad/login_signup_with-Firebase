import 'package:firebase2/ui/auth/verify_code.dart';
import 'package:firebase2/utils.dart';
import 'package:firebase2/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        child: Column(
          children: [

            SizedBox(height: 150,),
            TextFormField(
              controller: phoneNumberController,

              decoration: InputDecoration(
                hintText: '+92 3*******'
              ),

            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Send Code', loading: loading, onTap: (){

              setState(() {
                loading = true;
              });

              _auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });

                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false;
                    });
                  Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId , int? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                  setState(() {
                    loading = false;
                  });

                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });

                  });

            }),
          ],
        ),
      ),
    );
  }
}
