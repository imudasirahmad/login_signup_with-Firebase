import 'package:firebase2/ui/auth/login_screen.dart';
import 'package:firebase2/utils.dart';
import 'package:firebase2/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Sign Up')),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
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
                      decoration: const InputDecoration(
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController ,
                      obscureText: true,

                      decoration: const InputDecoration(
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

            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign Up' ,
              loading: loading,
              onTap: (){

                if(_formKey.currentState!.validate()){

                  setState(() {
                    loading = true;
                  });

                  auth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString()).then((value) {
                      setState(() {
                        loading = false;
                      });



                  }) .onError((error, stackTrace){Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });

                  });
                  print('Success');
                   emailController.clear();
                   passwordController.clear();



                }

              },),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text("Already Have a account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)  => const LoginScreen()));

                }, child: const Text('Sign In'))
              ],
            )

          ],
        ),
      ),
    );
  }
}
