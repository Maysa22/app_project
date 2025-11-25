import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/show_employees_cubit.dart';


const Color primaryColor = Color(0xFF087F81);

class ShowEmployeesScreen extends StatelessWidget {
  const ShowEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowEmployeesCubit()..getEmployees(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3FAFA),
        appBar: AppBar(
          title: const Text(
            'قائمة الموظفين',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
        ),

        body: BlocBuilder<ShowEmployeesCubit, ShowEmployeesState>(
          builder: (context, state) {
            var cubit = ShowEmployeesCubit.get(context);

            if (state is ShowEmployeesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (state is ShowEmployeesErrorState) {
              return Center(
                child: Text(
                  "خطأ: ${state.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (cubit.employees == null || cubit.employees!.isEmpty) {
              return const Center(
                child: Text(
                  "لا يوجد موظفين",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cubit.employees!.length,
              itemBuilder: (context, index) {
                final employee = cubit.employees![index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: primaryColor.withOpacity(0.25),
                      child: Text(
                        employee.firstName[0],
                        style: const TextStyle(
                          fontSize: 22,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    title: Text(
                      "${employee.firstName} ${employee.lastName}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.black87,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(Icons.business_outlined,
                                size: 18, color: Colors.black.withOpacity(0.7)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                employee.organization.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.email_outlined,
                                size: 18, color: Colors.black.withOpacity(0.7)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                employee.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
