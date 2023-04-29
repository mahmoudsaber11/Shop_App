import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubits/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitailState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
