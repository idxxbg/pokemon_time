import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';
import 'package:pokemon_time/presentation/screens/pokemon_detail_screen.dart';

class PokemonContainerWiget extends StatelessWidget {
  const PokemonContainerWiget({super.key, required this.pokemon});
  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final imageUrl = pokemon.sprites.other.officialArtwork.frontDefault;
    return OpenContainer(
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        openShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        transitionDuration: const Duration(milliseconds: 350),
        middleColor: Theme.of(context).colorScheme.surface,
        closedColor: Theme.of(context).colorScheme.surface,
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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                height: 200,
                width: 100,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported_rounded),
              ),
            ),
          );
        },
        openBuilder: (context, openAction) {
          return PokemonDetailScreen(pokemon: pokemon);
        });
  }
}
