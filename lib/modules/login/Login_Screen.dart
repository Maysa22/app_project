import 'package:app_project/modules/employee/show/show_employee_screen.dart';
import 'package:app_project/modules/login/cubit/login_cubit.dart';
import 'package:app_project/shared/network/remote/end_points.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/basic.dart';
import '../../styles/colors.dart' hide primaryColor;

class LogInAdminScreen extends StatefulWidget {
  const LogInAdminScreen({super.key});

  @override
  State<LogInAdminScreen> createState() => _LogInAdminScreenState();
}

class _LogInAdminScreenState extends State<LogInAdminScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'قم بالتحقق من البريد أو كلمة السر',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'تم تسجيل الدخول بنجاح',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowEmployeesScreen()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: primaryColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                double maxW = constraints.maxWidth;

                /// **Responsive width لمحتوى الفورم**
                double containerWidth = maxW > 900
                    ? maxW * 0.4
                    : maxW > 600
                    ? maxW * 0.6
                    : maxW * 0.9;

                return Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: containerWidth,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Text(
                              "قم بتسجيل الدخول",
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: maxW < 500 ? 28 : 40,
                              ),
                            ),
                            SizedBox(height: 20),

                            /// Email
                            CustomTextField(
                              label: "البريد الإلكتروني",
                              controller: emailController,
                              prefixIcon: Icons.email,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال البريد الإلكتروني";
                                }
                                if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "البريد الإلكتروني غير صالح";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            /// Password
                            CustomTextField(
                              label: "كلمة المرور",
                              controller: passwordController,
                              prefixIcon: Icons.lock,
                              suffixIcon: LoginCubit.get(context).suffix,
                              isPassword: LoginCubit.get(context).ispassword,
                              onSuffixTap: () {
                                LoginCubit.get(
                                  context,
                                ).changepasswordvisibility();
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

                            SizedBox(height: 15),

                            /// Button or Loading Indicator
                            state is! LoginLoadingState
                                ? SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      text: "تسجيل الدخول",
                                      color: primaryColor,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).adminLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
