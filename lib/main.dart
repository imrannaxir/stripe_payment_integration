import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_integration/home_screen.dart';
import 'package:stripe_payment_integration/stripe.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51NayHsLqKLwkLB47F7FyQvV6W1iSElmppDpsvmSO9kClKIIN7xrAG620F4xtHehDThboznl11jwlL7BdOk6MUE5p00bDqCcuIn';
      // await Stripe.instance.applySettings();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

/*
  For STRIPE PAYMENT INTEGRATION : 

   Email : imrannazeer2015804@gmail.com 
   Password : ImranNazeer@1122


   Some popular payment gateways supported by Flutter plugins include
   Stripe, PayPal, Braintree, Square, etc.


 */
