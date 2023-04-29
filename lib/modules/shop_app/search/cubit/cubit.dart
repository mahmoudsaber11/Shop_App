import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/shop_app/search_model.dart';
import 'package:news_app/modules/shop_app/search/cubit/states.dart';
import 'package:news_app/network/end_points.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: sEarch,
      data: {
        'text': text,
      },
      token:
          'buMt55pRam46AfHHC00O7RqyrnrZ6vMiEEs3gjTB3Pw80CU6d7O11TOfPmOzd4EjfhmFyH',
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccesslState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
