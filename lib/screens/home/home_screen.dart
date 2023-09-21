import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/helper/constant.dart';
import 'package:my_profile/helper/toast_utils.dart';
import 'package:my_profile/main.dart';
import 'package:my_profile/screens/login/login_screen.dart';
import 'package:my_profile/screens/profile/profile_screen.dart';

import '../../helper/widget_utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateNotifier);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purpleAccent,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: () {
              ref.read(appStateNotifier.notifier).onResetData();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);

            }, icon: const Icon(Icons.logout))
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildCircleAvatar(),
              verticalSpace(),
              buildText(appState.password,ProfileEditType.password),
              verticalSpaceSmall(),
              buildText(appState.email,ProfileEditType.email),
              verticalSpace(),
              buildSkillText("Skills",ProfileEditType.skills),
              verticalSpaceSmall(),
              Align(
                alignment: Alignment.topLeft,
                child: dynamicChips(appState.skills),
              ),
              verticalSpace(),
              buildSkillText("Work experience",ProfileEditType.skills),
              verticalSpaceSmall(),
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.work),
                    title: Text(appState.workExperience[index]),
                  );
                },
                itemCount: appState.workExperience.length,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),

              )
            ],
          )),
        ),
      ),
    );
  }

  Widget buildSkillText(String value,ProfileEditType editType) {
    return Row(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),

      ],
    );
  }

  Widget buildText(String value,ProfileEditType editType) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(value,editType),
            ),
          );
        }, icon: const Icon(Icons.edit),iconSize: 18,)

      ],
    );
  }

  CircleAvatar buildCircleAvatar() {
    final appState =  ref.read(appStateNotifier);

    return
     CircleAvatar(
      radius: 58,
      backgroundImage: FileImage(File(appState.image)),
      child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white70,
                child: IconButton(onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if(image!=null)
{
  ref.read(appStateNotifier.notifier).onImageChange(image.path);

}
                }, icon: Icon(Icons.edit)),
              ),
            ),
          ]
      ),
    );

  }
}
