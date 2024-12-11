import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/data/models/sub_models.dart';
import 'package:pokemon_time/app/bloc/pokemon_image_3d_cubit.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    super.key,
    required this.other,
    required this.height,
    required this.width,
    this.fit,
  });
  final double height;
  final double width;
  final BoxFit? fit;

  final OtherModel other;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonImage3DCubit, bool>(
      builder: (context, is3D) {
        return CachedNetworkImage(
          imageUrl: is3D
              ? other.home.frontDefault
              : other.officialArtwork.frontDefault,
          fit: fit,
          height: height,
          width: width,
          errorWidget: (context, url, error) => const Icon(
            Icons.image_not_supported_rounded,
            size: 50,
          ),
        );
      },
    );
  }
}
