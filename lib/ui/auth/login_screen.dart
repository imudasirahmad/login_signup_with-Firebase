import 'package:firebase2/ui/auth/login-with_phone.dart';
import 'package:firebase2/ui/auth/signup.dart';
import 'package:firebase2/ui/posts/postscreen.dart';
import 'package:firebase2/utils.dart';
import 'package:firebase2/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

    void Login(){
      setState(() {
        loading = true;
      });
      _auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){
            Utils().toastMessage(value.user!.email.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PostScreen()));

            setState(() {
              loading = false;
            });

      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
        setState(() {
          loading = true;
        });
      });
    }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return  true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                    child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController ,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          //helperText: 'i.e imudasirk@gmail.com',
                          prefixIcon: Icon(Icons.email_rounded)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address';
                        }
                        // Email format validation
                        final emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController ,
                      obscureText: true,

                      decoration: InputDecoration(
                          hintText: 'password',
                          //helperText: 'minimum 8 Characters',
                          prefixIcon: Icon(Icons.security)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Password';
                        }
                        return null;

                      },
                    ),

                  ],
                )),

                SizedBox(
                  height: 50,
                ),
                RoundButton(
                  loading: loading,
                  title: 'Login' ,
                  onTap: (){

                    if(_formKey.currentState!.validate()){
                      Login();
                    }
                },),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Don't Have a account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)  => SignUp()));

                    }, child: Text('Signup'))
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhone() ));

                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      //color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple)
                    ),
                    child: Center(
                      child: Text('Login with Phone Number' , style: TextStyle(color: Colors.deepPurple),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
