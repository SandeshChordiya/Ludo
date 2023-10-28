import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/ludo_start_screen.dart';

class OtpPasswordPage extends StatefulWidget {
  const OtpPasswordPage({super.key});

  @override
  State<OtpPasswordPage> createState() => _OtpPasswordPageState();
}

class _OtpPasswordPageState extends State<OtpPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otp1Controller = TextEditingController();
  final _otp2Controller = TextEditingController();
  final _otp3Controller = TextEditingController();
  final _otp4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/game screen images/2.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Image.asset(
                  "images/ludo logo/Super Ludo Gold.png",
                  scale: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: _otp1Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          counterText: "",
                          hintText: "*",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 1) {
                            return 'OTP code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: _otp2Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          counterText: "",
                          hintText: "*",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 1) {
                            return 'Please enter a valid OTP code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: _otp3Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          counterText: "",
                          hintText: "*",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 1) {
                            return 'Please enter a valid OTP code';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: _otp4Controller,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          counterText: "",
                          hintText: "*",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 1) {
                            return 'Please enter a valid OTP code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    if (_formKey.currentState!.validate()) {
                      // Perform login action here
                      String otpCode = _otp1Controller.text +
                          _otp2Controller.text +
                          _otp3Controller.text +
                          _otp4Controller.text;
                      debugPrint(otpCode);
                      if (otpCode == "1111") {
                        Get.to(() => const LudoStartScreenPage());
                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                  ),
                  child: const Text(
                    'Confirm Login',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
