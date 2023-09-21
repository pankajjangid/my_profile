import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_profile/helper/toast_utils.dart';
import 'package:my_profile/main.dart';
import 'package:my_profile/screens/home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
   return _LoginScreenState();
  }

}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isRememberMeChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  _doSignIn() {
    final  validCharacters = RegExp(r'^[a-zA-Z]+$');

    String email = emailController.text;
    String password = passwordController.text;
    bool isValidEmail = EmailValidator.validate(emailController.text);

    if(email.isEmpty) {
      ToastUtils.showErrorToast("Please enter email");
      return;
    }
    if(!isValidEmail){
      ToastUtils.showErrorToast("Please enter valid email");
      return;
    }
    if(password.isEmpty) {
      ToastUtils.showErrorToast("Please enter password");
      return;
    }
    if(!password.contains(validCharacters)) {
      ToastUtils.showErrorToast("Please enter valid password");
      return;
    }

    ref.watch(appStateNotifier.notifier).onEmailChange(email);
    ref.watch(appStateNotifier.notifier).onPasswordChange(password);


    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false);

  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateNotifier);
    final checkState =  ref.read(appStateNotifier);
    if(checkState.isRememberMeChecked){
      if(checkState.email.isNotEmpty && checkState.password.isNotEmpty){

        emailController.text = checkState.email;
        passwordController.text = checkState.password;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),

        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48.0,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300],
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                height: 48.0,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300],
                ),
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(fontSize: 16.0),
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
                height: 48.0,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _doSignIn();
                    },
                    child: const Text("Sign in", style: TextStyle(fontSize: 16.0))),
              ),
              Consumer(
                builder: (context, ref, child) {

                  return CheckboxListTile(
                    title: const Text("Remember me"),
                    controlAffinity: ListTileControlAffinity.leading, //checkbox at left

                    value: appState.isRememberMeChecked,
                    onChanged: (isChecked) {
                      ref.read(appStateNotifier.notifier).onRememberMeChange(isChecked ?? false);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
