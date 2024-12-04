import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenNavCubit extends Cubit<int> {
  ScreenNavCubit() : super(0);

  void onChangeScreen(value) {
    emit(value);
  }
}
