import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_profile/helper/toast_utils.dart';
import 'package:my_profile/main.dart';
import 'package:my_profile/screens/home/home_screen.dart';


enum ProfileEditType {
  email,
  password,
  image,
  skills,
  workHistory,
}

class ProfileScreen extends ConsumerStatefulWidget {
  final ProfileEditType editType;
  final String title;

  const ProfileScreen(this.title, this.editType, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState(editType, title);
  }
}

class _LoginScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  ProfileEditType editType;
  final String title;
  bool isRememberMeChecked = false;
  TextEditingController textEditingController = TextEditingController();


  _LoginScreenState(this.editType, this.title);

  _saveProfileData() {
    final validCharacters = RegExp(r'^[a-zA-Z]+$');

    String text = textEditingController.text;

    if (editType == ProfileEditType.email) {
      bool isValidEmail = EmailValidator.validate(text);

      if (text.isEmpty) {
        ToastUtils.showErrorToast("Please enter email");
        return;
      }
      if (!isValidEmail) {
        ToastUtils.showErrorToast("Please enter valid email");
        return;
      }
      ref.watch(appStateNotifier.notifier).onEmailChange(text);
    } else if (editType == ProfileEditType.password) {
      if (text.isEmpty) {
        ToastUtils.showErrorToast("Please enter password");
        return;
      }
      if (!text.contains(validCharacters)) {
        ToastUtils.showErrorToast("Please enter valid password");
        return;
      }
      ref.watch(appStateNotifier.notifier).onPasswordChange(text);
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false);
  }

  bool shouldShowPop() {
    if (editType == ProfileEditType.email) {
      return textEditingController.text != ref.read(appStateNotifier).email;
    } else if (editType == ProfileEditType.password) {
      return textEditingController.text != ref.read(appStateNotifier).password;
    } else {
      return false;
    }
  }

  Future<bool> showExitPopup() async {
    if (shouldShowPop()) {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Alert'),
              content: const Text(
                  'Your data will be lost , please click on button to save this data'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('Ok'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = title;
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateNotifier);
    return WillPopScope(
        onWillPop: () async {
          return showExitPopup();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
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
                      controller: textEditingController,
                      style: const TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        hintText: title,
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
                    height: 48.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          _saveProfileData();
                        },
                        child: const Text("Save",
                            style: TextStyle(fontSize: 16.0))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildSkillText(String value) {
    return Row(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
