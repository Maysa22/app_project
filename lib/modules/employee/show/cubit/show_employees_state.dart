part of 'show_employees_cubit.dart';

@immutable
sealed class ShowEmployeesState {}

final class ShowEmployeesInitial extends ShowEmployeesState {}
final class ShowEmployeesLoadingState extends ShowEmployeesState {}
final class ShowEmployeesSuccessState extends ShowEmployeesState {
  final ShowEmployees showEmployees;
  ShowEmployeesSuccessState(this.showEmployees);
}
final class ShowEmployeesErrorState extends ShowEmployeesState {
  final String error;
  ShowEmployeesErrorState(this.error);
}
