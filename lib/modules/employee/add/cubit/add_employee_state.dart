part of 'add_employee_cubit.dart';

@immutable
sealed class AddEmployeeState {}

final class AddEmployeeInitial extends AddEmployeeState {}
final class AddEmployeeLoadingState extends AddEmployeeState {

}
final class AddEmployeeSuccessState extends AddEmployeeState {
  AddEmployee addEmployee;
  AddEmployeeSuccessState(this.addEmployee);
}
final class AddEmployeeErrorState extends AddEmployeeState {
  String error;
  AddEmployeeErrorState(this.error);
}


///---------------organizations----------------------
class ShowOrganizationsInitialState extends AddEmployeeState {}
class ShowOrganizationsLoadingState extends AddEmployeeState{}
class ShowOrganizationsSuccessState extends AddEmployeeState{
  final OrganizationsResponse organizationsResponse;
  ShowOrganizationsSuccessState(this.organizationsResponse);
}

class ShowOrganizationssErrorState extends AddEmployeeState{
  final String error;
  ShowOrganizationssErrorState(this.error);
}

///-----------------------------------
class SelectOrgDropDownButtonState extends AddEmployeeState {}