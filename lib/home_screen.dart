// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   /*

//   */
//   Map<String, dynamic>? paymentIntentData;
//   /*

//   */
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           'Strike Payment',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {},
//             child: Container(
//               height: 60,
//               width: 200,
//               decoration: const BoxDecoration(
//                 color: Colors.green,
//               ),
//               child: const Center(
//                 child: Text('Pay'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> makePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent('20', 'USD');

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentData!['client_secret'],
//           applePay: true,
//           googlePay: true,
//           style: ThemeMode.dark,
//          // merchantCountryCode: 'US',
//           merchantDisplayName: 'Imran Nazeer',
//         ),
//       );

//       displayPaymentSheet();
//     } catch (e) {
//       print('Exception : ${e.toString()}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Exception : ${e.toString()}',
//           ),
//         ),
//       );
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       Stripe.instance.presentPaymentSheet(
//         parameters: PresentPaymentSheetParameters(
//           clientSecret: paymentIntentData!['client_secret'],
//           confirmPayment: true,
//         ),
//       );

//       setState(() {
//         paymentIntentData = null;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Paid Successfully',
//           ),
//         ),
//       );
//     } on StripeException catch (e) {
//       print(e.toString());

//       showDialog(
//         context: context,
//         builder: (context) {
//           return const AlertDialog(
//             content: Text(
//               'Canceled',
//             ),
//           );
//         },
//       );
//     }
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };

//       var response = await http.post(
//         Uri.parse(
//           'https://api.stripe.com/v1/payment_intents',
//         ),
//         body: body,
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51NayHsLqKLwkLB47vgYOoeYTcGaxMKGl6zEpwkbeksISgBJ6U5P8QhBnnV2KVornD297pYxsWd8iBOqr0uHvlm2T00YIZDbtbT',
//           'Content_Type': 'application/x-www-form-urlencoded',
//         },
//       );
//       return jsonDecode(response.body.toString());
//     } catch (e) {
//       print('Exception : ${e.toString()}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Exception : ${e.toString()}',
//           ),
//         ),
//       );
//     }
//   }

//   calculateAmount(String amount) {
//     final price = int.parse(amount) * 100;
//     return price;
//   }
// }

// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            // final paymentMethod = await Stripe.instance.createPaymentMethod(
            //     params: const PaymentMethodParams.card(
            //         paymentMethodData: PaymentMethodData()));
            await makePayment();
          },
          child: Container(
            height: 50,
            width: 200,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Pay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret: 'Your Secret Key',
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  //applePay: PaymentSheetApplePay.,
                  //googlePay: true,
                  //testEnv: true,
                  customFlow: true,
                  style: ThemeMode.dark,
                  // merchantCountryCode: 'US',
                  merchantDisplayName: 'Kashif'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              //       parameters: PresentPaymentSheetParameters(
              // clientSecret: paymentIntentData!['client_secret'],
              // confirmPayment: true,
              // )
              )
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51NayHsLqKLwkLB47vgYOoeYTcGaxMKGl6zEpwkbeksISgBJ6U5P8QhBnnV2KVornD297pYxsWd8iBOqr0uHvlm2T00YIZDbtbT',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
