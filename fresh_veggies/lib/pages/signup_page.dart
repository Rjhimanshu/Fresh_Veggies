import 'package:flutter/material.dart';
import 'package:fresh_veggies/pages/email_login.dart';
import 'package:fresh_veggies/services/firebase_auth_methods.dart';
import 'package:fresh_veggies/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';


class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
        setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
          "assets/img/signup.png"
        ),
        const SizedBox(height: 20.0,),
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Vx.blue800,
            ),
            ),
        
          const SizedBox(
                height: 28.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 20.0),
    
                   Material(
                          color: Vx.green800,
                          borderRadius:
                              BorderRadius.circular(50.0),
                          child: InkWell(
                            onTap: () => signUpUser(),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 150.0,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                      "Sign Up",

                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    
                                          
                                    ),     
                            ),
                          ),
                        ), 
                        const SizedBox(
                          height: 20.0,
                        ),
                         const Text(
                           "Or Signup using",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),

                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Vx.white,
                              child: Image.asset(
                                "assets/img/G1.png",
                                height: 30,
                                width: 30,
                                
                              ),
                            ), 
                            onTap: (){
                              context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                            },
                        
                          ),
                        ),

                        GestureDetector(
                          
                          child: CircleAvatar(
                            backgroundColor: Vx.gray500,
                            child: Image.asset(
                              "assets/img/F2.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          onTap: (){
                               context.read<FirebaseAuthMethods>().signInWithFacebook(context);
                          },
                        ),                 
                        ],
                  
                  ), 
             
          
          DefaultTextStyle(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          child: Wrap(
            children: [
              const Text('Already have an account ? '),
              GestureDetector(
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                onTap: () {
                 context.vxNav.push(Uri.parse(EmailPasswordLogin.routeName));
                },
              ),
            ],
          ),
        ),

        ],
      ).scrollVertical()
    );
  }
}