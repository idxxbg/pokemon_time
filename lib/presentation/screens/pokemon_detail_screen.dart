import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final PokemonModel pokemon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildPokemonImageWidget(
                imageUrl: pokemon.sprites.other.officialArtwork.frontDefault),
            _builNamePokemon(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _circleInfor('${pokemon.height.toString()}  inch', 'Height'),
                _rectangleInfo('${pokemon.weight.toString()}  pound', 'Weight'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _circleInfor('${pokemon.weight.toString()}  pound', 'Weight'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card _rectangleInfo(String pokemon, String text) {
    return Card(
      elevation: 2,
      child: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pokemon,
                overflow: TextOverflow.visible,
              ),
              Text(text),
            ],
          )),
    );
  }

  Card _circleInfor(String pokemon, String text) {
    return Card(
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pokemon,
              overflow: TextOverflow.visible,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  Hero _builNamePokemon() {
    return Hero(
      tag: pokemon.name,
      child: Material(
        color: Colors.transparent,
        child: Text(pokemon.name.capitalize()),
      ),
    );
  }

  _buildPokemonImageWidget({required String imageUrl}) {
    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: imageUrl,
        child: Material(
          color: Colors.transparent,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
