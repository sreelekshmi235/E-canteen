

// import 'package:flutter/material.dart';
// import 'package:smartcanteen/screens/home.dart';

// class LoginPagee extends StatefulWidget {
//   const LoginPagee({super.key});

//   @override
//   State<LoginPagee> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPagee> {

//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void login() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [

//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   "https://images.unsplash.com/photo-1504674900247-0877df9cc836"
//                 ), 
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           Container(
//             color: Colors.black.withOpacity(0.4),
//           ),

//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [

//                   const Text(
//                     "Smart Canteen Login",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, 
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   TextField(
//                     controller: usernameController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Username",
//                       labelStyle: const TextStyle(color: Colors.white),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       labelStyle: const TextStyle(color: Colors.white),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   ElevatedButton(
//                     onPressed: login,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 40, vertical: 15),
//                     ),
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),

//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:smartcanteen/screens/home.dart';

class LoginPagee extends StatefulWidget {
  const LoginPagee({super.key});

  @override
  State<LoginPagee> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagee> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1504674900247-0877df9cc836"
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,   // ✅ IMPORTANT
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Smart Canteen Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ✅ USERNAME FIELD
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username is required";
                        }
                        if (value.length < 4) {
                          return "Username must be at least 4 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // ✅ PASSWORD FIELD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "Include at least one uppercase letter";
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "Include at least one number";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}