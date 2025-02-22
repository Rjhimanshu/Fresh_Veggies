import 'package:flutter/material.dart';
import 'package:fresh_veggies/pages/phone_login.dart';
import 'package:fresh_veggies/pages/signup_page.dart';
import 'package:fresh_veggies/services/firebase_auth_methods.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:fresh_veggies/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';


class EmailPasswordLogin extends StatefulWidget {
  static String routeName = '/login';
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  void loginUser() async {
 await  context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        ); 
       final user = context.read<FirebaseAuthMethods>().user;
    if(user.email!=null)  {
          context.vxNav.push(Uri.parse(MyRoutes.homeRoute));  
    }
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          
          child: Column(
            children: [
              Image.asset(
                  "assets/img/login.png",
                  fit: BoxFit.cover,
              ),
              const SizedBox(
                  height: 20.0,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 30.0),
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
                            onTap: () => loginUser(),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: 150.0,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                      "Login",
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
                           "OR",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),

                      const SizedBox(
                               height: 20.0,
                        ), 

             Material(
                          color: Vx.purple800,
                          borderRadius:
                              BorderRadius.circular(50.0),
                          child: InkWell(
                            onTap: () {
                              context.vxNav.push(Uri.parse(PhoneScreen.routeName));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 200.0,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                      "Login with phone",
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

          DefaultTextStyle(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          child: Wrap(
            children: [
              const Text('New User ? '),
              GestureDetector(
                child: const Text(
                  'Signup',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  context.vxNav.push(Uri.parse(EmailPasswordSignup.routeName));
                },
              ),
            ],
          ),
        ),
            ],
          ).scrollVertical()
        ),
      
    );
  }
}