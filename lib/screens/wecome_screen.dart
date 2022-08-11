// import 'package:flutter/material.dart';
// // import '../../../contents.dart';
// // import '../sin_in_screen.dart';
// // import '../sin_out_screen.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   // As you can see we need more paddind on our btn
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SignUpScreen(),
//                         ),
//                       ),
//                       style: TextButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 8, 67, 63),
//                       ),
//                       child: const Text("Sign Up"),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: defaultPadding),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SignInScreen(),
//                             )),
//                         style: TextButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: const Color.fromARGB(255, 8, 67, 63),
//                           shape: const RoundedRectangleBorder(
//                             side: BorderSide(
//                               color: Color.fromARGB(255, 8, 67, 63),
//                             ),
//                           ),
//                         ),
//                         child: const Text("Sign In"),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: defaultPadding),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
