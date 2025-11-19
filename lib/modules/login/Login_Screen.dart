import 'package:app_project/modules/login/cubit/login_cubit.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/basic.dart';
import '../../styles/colors.dart' show primaryColor;

class LogInAdminScreen extends StatefulWidget {
  const LogInAdminScreen({super.key});

  @override
  State<LogInAdminScreen> createState() => _LogInAdminScreenState();
}

class _LogInAdminScreenState extends State<LogInAdminScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content:
                Text(state.toString(),
                    style: TextStyle(color: Colors.white))));
          }
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'Registered Successfully',
                  style: TextStyle(color: Colors.white),
                ))
            );


          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: primaryColor,
            body: Center(
              child: Container(
                width: w / 2,

                height: h / 2,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "قم بتسجيل الدخول",
                          style: TextStyle(
                            fontFamily:'Tajawal' ,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(height: 20,),
                        CustomTextField(
                          label: "البريد الإلكتروني",
                          controller: emailController,
                          prefixIcon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "الرجاء إدخال البريد الإلكتروني";
                            }
                            if (!value.contains("@") || !value.contains(".")) {
                              return "البريد الإلكتروني غير صالح";
                            }
                            return null;
                          },
                        ),

                        CustomTextField(
                          label: "كلمة المرور",
                          controller: passwordController,

                          prefixIcon: Icons.lock,
                          suffixIcon: LoginCubit.get(context).suffix,

                          isPassword: LoginCubit.get(context).ispassword,

                          onSuffixTap: () {
                            LoginCubit.get(context).changepasswordvisibility();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "الرجاء إدخال كلمة المرور";
                            }
                            if (value.length < 6) {
                              return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                            }
                            return null;
                          },
                        ),
                        state is! LoginLoadingState ?

                        Container(
                          width: 200,
                          child: CustomButton(
                            text: "تسجيل الدخول",
                            color: primaryColor,

                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).adminLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print("VALID — تسجيل الدخول جاري...");
                              } else {
                                print("NOT VALID");
                              }
                            },
                          ),
                        ) :
                        Center(child: CircularProgressIndicator(),)
                        ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
