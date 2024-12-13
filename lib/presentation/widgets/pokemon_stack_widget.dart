import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/data/models/pokemon_basic_info.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_cubit/get_pokemon_cubit.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_cubit/pokemon_state.dart';
import 'package:pokemon_time/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_image_widget.dart';

class PokemonStackWidget extends StatelessWidget {
  const PokemonStackWidget({super.key, required this.pokemon});
  final PokemonBasicInfo pokemon;

  @override
  Widget build(BuildContext context) {
    context.read<GetPokemonCubit>().getPokemon(pokemon.url);
    final imageUrl =
        pokemon.pokemon!.sprites.other.officialArtwork.frontDefault;
    return BlocBuilder<GetPokemonCubit, PokemonState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => PokemonDetailScreen(
                            pokemon: pokemon.pokemon!,
                          ),
                        ),
                      );
                    },
                    title: Material(
                      color: Colors.transparent,
                      child: Text(
                        pokemon.name.capitalize(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    subtitle: Text(
                        'Base Experience: ${pokemon.pokemon!.baseExperience.toString()}'),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Hero(
                  tag: imageUrl,
                  child: IgnorePointer(
                    child: PokemonImageWidget(
                      other: pokemon.pokemon!.sprites.other,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
