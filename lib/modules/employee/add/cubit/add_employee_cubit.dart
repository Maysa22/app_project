import 'package:app_project/models/organizations_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/add_employee_model.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial());
  static AddEmployeeCubit get(context) => BlocProvider.of(context);
  AddEmployee? addEmployee;
  int? dropDownValueOrg ;
  void changeOrgDropDownButton(int newValue)
  {
    dropDownValueOrg = newValue;
    emit(SelectOrgDropDownButtonState());
  }

  void addEmployeeFunc({
    required String firstName,
    required String lastName,
    required String email,
    required int org,
  }) {
    emit(AddEmployeeLoadingState());
    DioHelper.postData(
          url: ADDEMPLOYEE,
          token: CacheHelper.getToken(),
          data: {
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'organization_id':org,
          },
        )
        .then((value) {
          print(value?.data);
          addEmployee = AddEmployee.fromJson(value?.data);
          print(addEmployee!.phone);
          print(addEmployee!.firstName);

          emit(AddEmployeeSuccessState(addEmployee!));
        })
        .catchError((error) {
          print(error.toString());
          emit(AddEmployeeErrorState(error.toString()));
        });
  }

  OrganizationsResponse? organizationsResponse;
  List<dynamic>? organizations;
  List<DropdownMenuItem<int>> menuItemsOrg = [];
  void getOrganizations() {
    emit(ShowOrganizationsLoadingState());
    DioHelper.getData(
        url: ORGANIZATIONS,
            token: CacheHelper.getToken(),

    )
        .then((value) {
          print(value?.data);
          organizationsResponse = OrganizationsResponse.fromJson(value?.data);
          print(organizationsResponse?.message);
          print(organizationsResponse?.data?[0].name);
          organizations = organizationsResponse?.data;
          print(organizations?[1].name);
          menuItemsOrg = organizations!.map((org) {
            return DropdownMenuItem<int>(
              value: org.id,
              child: Text(org.name),
            );
          }).toList();
          emit(ShowOrganizationsSuccessState(organizationsResponse!));
        })
        .catchError((error) {
          print(error.toString());
          emit(ShowOrganizationssErrorState(error.toString()));
        });
  }
}
