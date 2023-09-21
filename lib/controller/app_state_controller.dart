
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_profile/model/app_state.dart';

class AppStateController extends StateNotifier<AppState>{
  AppStateController(super.state);

  void onImageChange(String image){
    state =  state.copyWith(image: image);
  }
  void onEmailChange(String email){
    state =  state.copyWith(email: email);
  }

  void onPasswordChange(String password){
    state =  state.copyWith(password: password);
  }
  void onRememberMeChange(bool isChecked){
    state =  state.copyWith(isRememberMeChecked: isChecked);
  }

  void onResetData(){
    if(!state.isRememberMeChecked){
      state =  state.copyWith(
        email: "",password: "",isRememberMeChecked: false,image: ""
      );

    }
  }


}