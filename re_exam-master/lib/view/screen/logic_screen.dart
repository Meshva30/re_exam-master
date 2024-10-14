import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_exam/view/screen/home_screen.dart';
import '../../controller/sigup_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log In',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Email',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    labelText: 'Enter your email',
                    labelStyle: GoogleFonts.poppins(
                      color: Color(0xffC7C9D9),
                      fontSize: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Password',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    labelText: 'Enter your password',
                    labelStyle: GoogleFonts.poppins(
                      color: Color(0xffC7C9D9),
                      fontSize: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: GoogleFonts.poppins(
                      color: Color(0xffBDBDBD),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(HomeScreen());
                    },
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  controller.signInMethod(
                      controller.txtEmail.text, controller.txtPassword.text);
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff005667),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
