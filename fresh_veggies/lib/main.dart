import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fresh_veggies/core/store.dart';
import 'package:fresh_veggies/firebase_options.dart';
import 'package:fresh_veggies/pages/cart_page.dart';
import 'package:fresh_veggies/pages/email_login.dart';
import 'package:fresh_veggies/pages/home_detail_page.dart';
import 'package:fresh_veggies/pages/home_page.dart';
import 'package:fresh_veggies/pages/phone_login.dart';
import 'package:fresh_veggies/pages/signup_page.dart';
import 'package:fresh_veggies/services/firebase_auth_methods.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:fresh_veggies/widgets/themes.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    FacebookAuth.i.webInitialize(
      appId: "1:169388457291:ios:bb26ca69346bb1dc393cce", // Replace with your app id
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }
  setPathUrlStrategy();
   runApp(VxState(store: MyStore(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp.router(
      
        themeMode: ThemeMode.system,
         theme: MyTheme.lightTheme(context),
       //  darkTheme: MyTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        routeInformationParser: VxInformationParser(),
        routerDelegate: VxNavigator(
    
        routes: {
          "/" : (_,__) => const MaterialPage(child: AuthWrapper()),
          MyRoutes.homeRoute:(_,__) => MaterialPage(child: HomePage()),
          MyRoutes.homeDetailsRoute:(uri, _){
            final catalog = (VxState.store as MyStore)
            .catalog.getById(int.parse(uri.queryParameters["id"].toString()));
            return MaterialPage(child: HomeDetailPage(
            catalog: catalog,
          ));
          },

          MyRoutes.cartRoute:(_,__) => MaterialPage(child: CartPage()),
          EmailPasswordLogin.routeName :(_,__) => const MaterialPage(child: EmailPasswordLogin()),
          EmailPasswordSignup.routeName :(_,__) => const MaterialPage(child: EmailPasswordSignup()),
          PhoneScreen.routeName :(_,__) => const MaterialPage(child: PhoneScreen()),
        },
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return   HomePage();
    }
    return const EmailPasswordSignup() ;
    
  }
}

