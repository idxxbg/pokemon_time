import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/common/style/padding.dart';
import 'package:pokemon_time/common/style/text_styles.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_page_cubit/pokemon_page_cubit.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_stack_widget.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

import '../bloc/list_pokemon_cubit/get_list_pokemon_cubit.dart';
import '../bloc/list_pokemon_cubit/pokemon_list_state.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetListPokemonCubit>();
    if (cubit.state is! PokemonListLoaded) {
      cubit.fetchPokemonList(0); // Chỉ tải nếu chưa có dữ liệu
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetListPokemonCubit>();
    final pageCubit = context.read<PokemonPageCubit>();

    return BlocBuilder<PokemonPageCubit, int>(
      builder: (context, state) {
        return BlocListener<PokemonPageCubit, int>(
          listener: (context, state) {
            cubit.fetchPokemonList(state); // Chỉ tải nếu có thay đổi page
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Pokémon List",
                style: TextStyles.appBarTitle,
              ),
            ),
            body: BlocBuilder<GetListPokemonCubit, PokemonListState>(
              builder: (context, state) {
                if (state is PokemonListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PokemonListLoaded) {
                  return RefreshIndicator(
                    strokeWidth: 3,
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      return cubit.fetchPokemonList(pageCubit.state);
                    },
                    child: ListView.builder(
                      padding: Paddings.defaultPadding,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.pokemonList.length,
                      itemBuilder: (context, index) {
                        final pokemon = state.pokemonList[index];
                        return PokemonStackWidget(pokemon: pokemon);
                      },
                    ),
                  );
                } else if (state is PokemonListError) {
                  return Center(child: Text(state.error));
                }
                return const Center(
                    child: Text("Pull down to load Pokémon! ⬇"));
              },
            ),
            floatingActionButton:
                BlocBuilder<GetListPokemonCubit, PokemonListState>(
              builder: (context, pokemonState) {
                bool isLoading = pokemonState is PokemonListLoading;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Visibility(
                    //   visible: state != 0,
                    //   child: FloatingActionButton(
                    //     shape: const CircleBorder(),
                    //     heroTag: 'previous',
                    //     onPressed: () => pageCubit.previous(),
                    //     child: const Icon(Icons.arrow_back_ios_rounded),
                    //   ),
                    // ),
                    state != 0
                        ? FloatingActionButton(
                            shape: const CircleBorder(),
                            heroTag: 'previous',
                            onPressed:
                                isLoading ? null : () => pageCubit.previous(),
                            child: const Icon(Icons.arrow_back_ios_rounded),
                          )
                        : const SizedBox(
                            height: kFloatingActionButtonTurnInterval,
                            width: kFloatingActionButtonMargin,
                          ),
                    Visibility(
                      visible: state != 0,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Text(
                              'page: ${(state / 20 + 1).round().toString()}'
                                  .capitalize()),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state != 1301,
                      child: state == 0
                          ? FloatingActionButton.extended(
                              // shape: const rectang(),
                              heroTag: 'big_next',
                              onPressed:
                                  isLoading ? null : () => pageCubit.nextPage(),
                              label: const Row(
                                children: [
                                  Text('Next'),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            )
                          : FloatingActionButton(
                              shape: const CircleBorder(),
                              heroTag: 'next',
                              onPressed:
                                  isLoading ? null : () => pageCubit.nextPage(),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                            ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          ),
        );
      },
    );
  }
}
