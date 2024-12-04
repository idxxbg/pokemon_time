import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonPageCubit extends Cubit<int> {
  PokemonPageCubit() : super(0);

  void nextPage() {
    emit(state + 20);
  }

  void previous() {
    emit(state - 20);
  }
}
