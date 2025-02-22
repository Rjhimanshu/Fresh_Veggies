import 'package:flutter/material.dart';
import 'package:fresh_veggies/services/firebase_auth_methods.dart';
import 'package:fresh_veggies/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();
   
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    setState(() {});
   
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          
          children: [
              Image.asset(
                    "assets/img/phone_login.png",
                    fit: BoxFit.cover,
                ),
               const SizedBox(
                  height: 30.0,
                ),
              
             const Text(
                 "Login With Phone",
                 style: TextStyle(
                   fontSize:  30.0,
                   fontWeight: FontWeight.bold,
                 ),
             ),
             const SizedBox(
                height: 70.0,
             ),
             Container(
               margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: phoneController,
                hintText: '+91 Enter phone number',
              ),
             ),

             const SizedBox(
                  height: 20.0,
             ),

               
               Material(
                          color: Vx.green800,
                          borderRadius:
                              BorderRadius.circular(50.0),
                          child: InkWell(
                            onTap: () {
               context
                   .read<FirebaseAuthMethods>()
                   .phoneSignIn(context, phoneController.text);
             },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 150.0,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                      "SEND OTP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                              
                            ),
                          ),
                        ),            
          ],
        ).scrollVertical()
      ),
    );
  }
}