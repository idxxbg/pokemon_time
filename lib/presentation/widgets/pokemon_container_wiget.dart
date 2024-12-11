import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';
import 'package:pokemon_time/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_image_widget.dart';

class PokemonContainerWiget extends StatelessWidget {
  const PokemonContainerWiget({super.key, required this.pokemon});
  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        transitionType: ContainerTransitionType.fade,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        openShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        transitionDuration: const Duration(milliseconds: 350),
        middleColor: Theme.of(context).colorScheme.surface,
        closedColor: Theme.of(context).colorScheme.surface,
        openColor: Theme.of(context).colorScheme.surface,
        closedBuilder: (context, closeaction) {
          return SizedBox(
            height: 250,
            width: MediaQuery.sizeOf(context).width,
            child: GridTile(
              footer: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Center(
                  child: Text(
                    pokemon.name.capitalize(),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              child: PokemonImageWidget(
                other: pokemon.sprites.other,
                height: 150,
                width: 100,
              ),
            ),
          );
        },
        openBuilder: (context, openAction) {
          return PokemonDetailScreen(pokemon: pokemon);
        });
  }
}
