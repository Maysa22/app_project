import 'package:app_project/models/show_employees_model.dart';
import 'package:app_project/shared/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cubit_form/cubit_form.dart' show BlocProvider;
import 'package:meta/meta.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

part 'show_employees_state.dart';

class ShowEmployeesCubit extends Cubit<ShowEmployeesState> {
  ShowEmployeesCubit() : super(ShowEmployeesInitial());
  static ShowEmployeesCubit get(context) => BlocProvider.of(context);
  ShowEmployees? showEmployees;
  List <dynamic>? employees;
  void getEmployees()
  {
    emit(ShowEmployeesLoadingState());
    DioHelper.getData(
      url: SHOWEMPLOYEE,
      token: CacheHelper.getToken(),
    ).then((value) {
      print(value?.data);
      showEmployees=ShowEmployees.fromJson(value?.data);
      print(showEmployees?.success);
      print(showEmployees?.message);
      employees=showEmployees?.data;
      emit(ShowEmployeesSuccessState(showEmployees!));
    }).catchError((error){
      print(error.toString());
      emit(ShowEmployeesErrorState(error.toString()));
    });

  }
}
