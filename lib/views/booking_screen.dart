import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:konzept_practical/views/homepage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingScreen extends StatefulWidget {
  final String mobile;
  const BookingScreen({super.key, required this.mobile});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var amountController = TextEditingController();
  final _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  showFailedDialog(PaymentFailureResponse response) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            body: Text('Payment Failed due to ${response.message}'))
        .show();
  }

  showSuccessDialog() {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            body: const Text('Payment Successful'))
        .show();
  }

  showDialog(ExternalWalletResponse response) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            body: Text('Payment Failed due to ${response.walletName}'))
        .show();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showSuccessDialog();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showFailedDialog(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showDialog(response);
  }

  pay() {
    var options = {
      'key': 'rzp_test_tIJR06R7kQazqK',
      'amount': 5250,
      'name': 'Raj kumar Patel',
      'description': 'Booking Payment by Raj kumar Patel',
      'prefill': {'contact': widget.mobile, 'email': 'rajkumar07793@gmail.com'}
    };
    _razorpay.open(options);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Booking',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(hintText: selectedDay.toString()),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                decoration: InputDecoration(hintText: widget.mobile),
              ),
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Amount'),
                        Text('5000'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('TAX'),
                        Text('250'),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('TOTAL'),
                  Text('5250'),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: pay,
                  child: const Text("Book"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
