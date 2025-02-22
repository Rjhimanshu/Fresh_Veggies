import 'package:flutter/material.dart';
import 'package:fresh_veggies/services/firebase_auth_methods.dart';
import 'package:fresh_veggies/widgets/custom_button.dart';
import 'package:provider/provider.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
       
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
                
            const DrawerHeader(
              child: Text(
              "Profile",
              
              style: TextStyle(
                decoration: TextDecoration.underline,
                 fontSize: 30,
                 fontWeight: FontWeight.bold,
                 color: Colors.blue,
              ),
              
            ),
            
            
            ),

                   // when user signs anonymously or with phone, there is no email
            if (!user.isAnonymous && user.phoneNumber == null) Text(user.email!),
             // if (!user.isAnonymous && user.phoneNumber == null)
               Text(user.providerData[0].providerId),
            // display phone number only when user's phone number is not null
            if (user.phoneNumber != null) Text(user.phoneNumber!),
            // uid is always available for every sign in method
             Text(user.uid),
            // // display the button only when the user email is not verified
            // // or isnt an anonymous user
            if (!user.emailVerified && !user.isAnonymous)
              CustomButton(
                onTap: () {
                  context
                      .read<FirebaseAuthMethods>()
                      .sendEmailVerification(context);
                },
                text: 'Verify Email',
              ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              text: 'Sign Out',
            ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().deleteAccount(context);
              },
              text: 'Delete Account',
            ),
              
              
              // DrawerHeader(
              //   padding: EdgeInsets.zero,
              //   child: UserAccountsDrawerHeader(
              //     margin: EdgeInsets.zero,
              //     accountName: Text("Pawan Kumar"),
              //     accountEmail: Text("mtechviral@gmail.com"),
              //     currentAccountPicture: CircleAvatar(
              //       backgroundImage: NetworkImage(imageUrl),
              //     ),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(
              //     CupertinoIcons.home,
              //     color: Colors.white,
              //   ),
              //   title: Text(
              //     "Home",
              //     textScaleFactor: 1.2,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(
              //     CupertinoIcons.profile_circled,
              //     color: Colors.white,
              //   ),
              //   title: Text(
              //     "Profile",
              //     textScaleFactor: 1.2,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(
              //     CupertinoIcons.mail,
              //     color: Colors.white,
              //   ),
              //   title: Text(
              //     "Email me",
              //     textScaleFactor: 1.2,
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}