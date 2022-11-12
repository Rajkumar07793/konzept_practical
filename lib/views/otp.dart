import 'package:flutter/material.dart';
import 'package:konzept_practical/services/api/verify_otp.dart';
import 'package:konzept_practical/views/booking_screen.dart';

class OtpScreen extends StatefulWidget {
  final String mobile;

  const OtpScreen({
    Key? key,
    required this.mobile,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpController = TextEditingController();
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
                  'OTP',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter OTP',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      verifyOtp(widget.mobile, otpController.text)
                          .then((value) {
                        // print(value.message);

                        if (value.statusCode == 200) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => BookingScreen(
                                    mobile: value.data!.mobile,
                                  )));
                        }
                      });
                    },
                    child: const Text('Verify')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
