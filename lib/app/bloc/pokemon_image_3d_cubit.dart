import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/share_prerences.dart';

class PokemonImage3DCubit extends Cubit<bool> {
  PokemonImage3DCubit({
    required this.image3DSharedPrerences,
  }) : super(false) {
    loadImageStyle();
  }
  final Image3DSharedPrerences image3DSharedPrerences;

  // bool is3D = false;
  Future<void> loadImageStyle() async {
    bool is3D = await image3DSharedPrerences.get3DMode();
    emit(is3D ? true : false);
  }

  Future<void> onChange3Dstyle() async {
    HapticFeedback.lightImpact();
    final is3D = state == true;
    emit(is3D ? false : true);
    // luu lai sau khi chuyen sang dang phu dinh
    await image3DSharedPrerences.set3DMode(!is3D);
  }
}
