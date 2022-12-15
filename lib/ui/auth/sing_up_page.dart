import 'package:device_shop/data/models/user_model.dart';
import 'package:device_shop/ui/auth/widgets/my_rich_text.dart';
import 'package:device_shop/utils/color.dart';
import 'package:device_shop/utils/my_utils.dart';
import 'package:device_shop/utils/style.dart';
import 'package:device_shop/view_models/auth_view_model.dart';
import 'package:device_shop/view_models/profile_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  final VoidCallback onClickedSignIn;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: AppBar(
          title: const Text(
            "Sign Up",
          )),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const  SizedBox(height: 20),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Enter a valid email"
                      : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Email"),
                ),
              ),
             const SizedBox(height: 20),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                  password != null && password.length < 6
                      ? "Enter at least 6 character !"
                      : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Password"),
                ),
              ),
            const  SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                  password != null && password.length < 6
                      ? "Enter at least 6 character !"
                      : null,
                  style: MyTextStyle.sfProRegular.copyWith(
                    color: MyColors.white,
                    fontSize: 17,
                  ),
                  decoration: getInputDecoration(label: "Confirm password"),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(onPressed: signUp, child: const Text("Sign Up")),
              const SizedBox(height: 20),
              MyRichText(
                onTap: widget.onClickedSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (confirmPassword == password) {
      await Provider.of<AuthViewModel>(context, listen: false).signUp(
        email: email,
        password: password,
      );
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if(!mounted) return;
      Provider.of<ProfileViewModel>(context, listen: false).addUser(
        UserModel(
            docId: "",
            age: 0,
            userId: FirebaseAuth.instance.currentUser!.uid,
            fullName: "",
            email: email,
            createdAt: DateTime.now().toString(),
            imageUrl: "",
            fcmToken: fcmToken ?? ""),
      );
    } else {
      MyUtils.getMyToast(message: "Passwords don't match!");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}