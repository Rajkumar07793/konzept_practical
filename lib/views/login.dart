import 'package:flutter/material.dart';
import 'package:konzept_practical/services/api/login.dart';
import 'package:konzept_practical/views/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter Mobile Number',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      login(mobileController.text).then((value) {
                        if (value.statusCode == 200) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OtpScreen(
                                    mobile: mobileController.text,
                                  )));
                        }
                      });
                    },
                    child: const Text('Login via OTP')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
