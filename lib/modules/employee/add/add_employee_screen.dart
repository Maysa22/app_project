import 'package:app_project/modules/login/cubit/login_cubit.dart';
import 'package:app_project/shared/components/basic.dart';
import 'package:cubit_form/cubit_form.dart';

import 'package:flutter/material.dart';
import '../../../styles/colors.dart' show primaryColor;
import 'cubit/add_employee_cubit.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final addEmpFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeCubit()..getOrganizations(),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('قم بالتحقق من المعلومات', style: TextStyle(color: Colors.white)),
              ),
            );
          }

          if (state is AddEmployeeSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('تمت الإضافة بنجاح', style: TextStyle(color: Colors.white)),
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = AddEmployeeCubit.get(context);

          return Scaffold(
            backgroundColor: primaryColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                double maxW = constraints.maxWidth;

                double containerWidth = maxW > 600
                    ? maxW * 0.7
                    : maxW > 500
                    ? maxW * 0.9
                    : maxW * 0.95;

                return Center(
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: containerWidth,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Form(
                        key: addEmpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),

                            Text(
                              "إضافة موظف جديد",
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: maxW < 500 ? 26 : 36,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),

                            const SizedBox(height: 30),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: "الاسم الأول",
                                    controller: firstNameController,
                                    prefixIcon: Icons.person,
                                    validator: (value) {
                                      if (value!.isEmpty) return "الرجاء إدخال الاسم الأول";
                                      if (value.length < 2) return "الاسم غير صالح";
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: CustomTextField(
                                    label: "الاسم الأخير",
                                    controller: lastnameController,
                                    prefixIcon: Icons.person,
                                    validator: (value) {
                                      if (value!.isEmpty) return "الرجاء إدخال الاسم الأخير";
                                      if (value.length < 2) return "الاسم غير صالح";
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                              label: "البريد الإلكتروني",
                              controller: emailController,
                              prefixIcon: Icons.email,
                              validator: (value) {
                                if (value!.isEmpty) return "الرجاء إدخال البريد الإلكتروني";
                                if (!value.contains('@') || !value.contains('.')) {
                                  return "البريد الإلكتروني غير صالح";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor, width: 1.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: DropdownButton<int>(
                                value: cubit.dropDownValueOrg,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                underline: const SizedBox(),
                                hint: const Text(
                                  'اختر المنظمة',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onChanged: (newValue) {
                                  cubit.changeOrgDropDownButton(newValue!);
                                },
                                items: cubit.menuItemsOrg,
                              ),
                            ),

                            const SizedBox(height: 35),

                            state is! AddEmployeeLoadingState
                                ? SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: "إضافة الموظف",
                                color: primaryColor,
                                onPressed: () {
                                  if (addEmpFormKey.currentState!.validate()) {

                                    if (cubit.dropDownValueOrg == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.orange,
                                            content: Text('الرجاء اختيار منظمة',)

                                        ),
                                      );
                                      return;
                                    }

                                    cubit.addEmployeeFunc(
                                      firstName: firstNameController.text,
                                      lastName: lastnameController.text,
                                      email: emailController.text,
                                      org: cubit.dropDownValueOrg!,
                                    );
                                  }
                                },

                              ),
                            )
                                : const Center(child: CircularProgressIndicator(
                              color: primaryColor,
                            )),
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
