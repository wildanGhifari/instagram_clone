import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_layout.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool onLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List userImagePicked = await pickImage(ImageSource.gallery);
    setState(() {
      _image = userImagePicked;
    });
  }

  void signupUser() async {
    setState(() {
      onLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      onLoading = false;
    });

    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebLayout(),
            mobileScreenLayout: MobileLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Svg image for Logo
                SvgPicture.asset(
                  'instagram_text_logo.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  height: 64,
                ),
                const SizedBox(height: 64),
                // Circular image
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                              "https://t3.ftcdn.net/jpg/00/64/67/52/360_F_64675209_7ve2XQANuzuHjMZXP3aIYIpsDKEbF5dD.jpg",
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade50),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade600)),
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                // Text field for username
                TextFieldInput(
                  hintText: 'Enter username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),
                const SizedBox(height: 16),
                // Text field for Email
                TextFieldInput(
                  hintText: 'your@mail.com',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(height: 16),
                // Text field for Password
                TextFieldInput(
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(height: 16),
                // Text field for Bio
                TextFieldInput(
                  hintText: 'Write a little bit about you...',
                  textInputType: TextInputType.multiline,
                  textEditingController: _bioController,
                ),
                const SizedBox(height: 24),
                // Button login
                InkWell(
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: signupUser,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sign Up"),
                          const SizedBox(width: 8),
                          onLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                // Transitioning to signing up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Alrady have an account? "),
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
