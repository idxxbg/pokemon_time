import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonPageCubit extends Cubit<int> {
  PokemonPageCubit() : super(0);

  Future<void> nextPage() async {
    emit(state + 20);
  }

  Future<void> previous() async {
    emit(state - 20);
  }
}
