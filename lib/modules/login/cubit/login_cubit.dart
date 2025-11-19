import 'package:app_project/models/admin_model.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../shared/network/remote/dio_helper.dart' show DioHelper;
import '../../../shared/network/remote/end_points.dart' show LOGIN;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  AdminResponse ?admin;
  void adminLogin(
      {
        required String email,
        required String password,

      })
  {
    emit(LoginLoadingState());
    DioHelper.postData(

        url: LOGIN,
        data: {
          'identifier':email,
          'password':password,
        }).then((value) {

      print(value?.data);
      admin= AdminResponse.fromJson(value?.data);
      print(admin!.data!.token);
      print(admin!.data!.user);

      emit(LoginSuccessState(admin!));

    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });

  }




  IconData suffix = Icons.visibility;
  bool ispassword = true;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(AdminLoginChangePasswordVisibilityState());
  }
}
