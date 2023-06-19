import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        // Wrap the Card with Center widget
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Set mainAxisSize to min to allow the card to take up only the necessary space
                children: [
                  Form(
                    //key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          //controller: _emailEditingController,
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".")
                              ? "Enter a valid email or password"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        TextFormField(
                          //controller: _passwordEditingController,
                          validator: (val) => val!.isEmpty || (val.length < 5)
                              ? "Enter a valid email or password"
                              : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.lock),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(height: 5),
                        GestureDetector(
                          //onTap: _goToRegister,
                          child: const Text(
                            "New Account?",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          //onTap: _forgotDialog,
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Column(
                    children: [
                      Form(
                          //key: _formKey,
                          child: Column(
                        children: [
                          TextFormField(
                            //controller: _emailEditingController,
                            validator: (val) => val!.isEmpty ||
                                    !val.contains("@") ||
                                    !val.contains(".")
                                ? "Enter a valid email or password"
                                : null,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.email),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                )),
                          ),
                          TextFormField(
                            //controller: _passwordEditingController,
                            validator: (val) => val!.isEmpty || (val.length < 5)
                                ? "Enter a valid email or password"
                                : null,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.lock),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                )),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            //onTap: _goToRegister,
                            child: const Text(
                              "New Account?",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            //onTap: _forgotDialog,
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
*/