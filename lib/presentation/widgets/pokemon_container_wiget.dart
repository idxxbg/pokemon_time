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
    return SizedBox(
      height: 250,
      width: MediaQuery.sizeOf(context).width,
      child: InkWell(
        splashColor: Colors.white24,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PokemonDetailScreen(pokemon: pokemon)));
        },
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
          child: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              // placeholder: (context, url) => const Icon(Icons.image_aspect_ratio),
              fit: BoxFit.fitWidth,
              height: 200,
              width: 100,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
