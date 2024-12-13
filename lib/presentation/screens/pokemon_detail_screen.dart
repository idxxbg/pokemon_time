import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/common/style/padding.dart';
import 'package:pokemon_time/common/style/text_styles.dart';
import 'package:pokemon_time/data/models/pokemon_model.dart';
import 'package:pokemon_time/data/models/sub_models.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_image_widget.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final PokemonModel pokemon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        centerTitle: true,
        title: const Text(
          'Pokémon Details',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Padding(
        padding: Paddings.noHeaderPadding,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPokemonImageWidget(other: pokemon.sprites.other),
                _builNamePokemon(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _circleInfor(
                        '${pokemon.height.toString()}  inch', 'Height'),
                    _rectangleInfo(
                        '${pokemon.weight.toString()}  pound', 'Weight'),
                  ],
                ),
                _builCardInfo(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(pokemon.types.length, (int i) {
                        final type = pokemon.types[i].type;
                        return Card(
                          child: Padding(
                            padding: Paddings.smallPadding,
                            child: Text(
                              type.name.toString().capitalize(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Card _builCardInfo() {
    final baseExperience = pokemon.baseExperience;
    return Card(
      elevation: 0.9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        leading: CircleAvatar(child: Text(baseExperience.toString())),
        title: const Text('Base Experience:'),
        subtitle: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(20),
          minHeight: 5,
          value: (pokemon.baseExperience / 500).clamp(0.0, 1.0),
          backgroundColor: Colors.grey,
          color: baseExperience > 200 ? Colors.red : Colors.green,
        ),
        trailing: Icon(
          pokemon.baseExperience > 200
              ? CupertinoIcons.flame_fill
              : CupertinoIcons.flame,
          color: Colors.red,
        )
            .animate(
              onPlay: (controller) => controller.loop(
                count: 4,
              ), // Lặp animation
            )
            .scaleXY(
              begin: 1.5,
              end: 1.3,
            )
            .shake(
              offset: const Offset(0.1, 0.1),
              delay: 200.ms,
              duration: 1500.ms,
              curve: Curves.easeOutCirc,
            )
            .fade(
              duration: 1.seconds, // Thời gian mờ
              begin: 0.8, // Độ mờ ban đầu
              end: 1.0, // Độ sáng tối đa
            ),
      ),
    );
  }

  _buildPokemonImageWidget({required OtherModel other}) {
    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: other.officialArtwork.frontDefault,
        child: Material(
          color: Colors.transparent,
          child: PokemonImageWidget(
            other: other,
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
        ),
      ),
    )
        .animate()
        .scaleXY(delay: 800.ms, begin: 0.8, end: 1)
        .shimmer(duration: 3.seconds, curve: Curves.easeInOutCirc);
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

  Text _builNamePokemon(BuildContext context) {
    return Text(
      pokemon.name.capitalize(),
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
