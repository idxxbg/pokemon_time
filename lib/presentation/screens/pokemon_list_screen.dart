import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glass/glass.dart';
import 'package:pokemon_time/common/extenstions/extenstions.dart';
import 'package:pokemon_time/common/style/padding.dart';
import 'package:pokemon_time/common/style/text_styles.dart';
import 'package:pokemon_time/presentation/bloc/pokemon_page_cubit/pokemon_page_cubit.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_container_wiget.dart';
import 'package:pokemon_time/presentation/widgets/pokemon_stack_widget.dart';

import '../bloc/list_pokemon_cubit/get_list_pokemon_cubit.dart';
import '../bloc/list_pokemon_cubit/pokemon_list_state.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  // TabBar tabBar = [
  //   Tab[];
  // ]

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
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Pokémon List",
                  style: TextStyles.appBarTitle,
                ),
                bottom: const TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.line_style_rounded),
                  ),
                  Tab(
                    icon: Icon(Icons.grid_view_rounded),
                  )
                ]),
              ),
              body: TabBarView(
                children: [
                  _listviewBuilder(
                    cubit,
                    pageCubit,
                  ),
                  _gridviewBuilder(cubit, pageCubit)
                ],
              ),
              floatingActionButton:
                  BlocBuilder<GetListPokemonCubit, PokemonListState>(
                builder: (context, pokemonState) {
                  bool isLoading = pokemonState is PokemonListLoading;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      state != 0
                          ? FloatingActionButton(
                              tooltip: 'Previous page',
                              shape: const CircleBorder(),
                              heroTag: 'previous',
                              onPressed:
                                  isLoading ? null : () => pageCubit.previous(),
                              child: const Icon(Icons.first_page_sharp),
                            )
                          : const SizedBox(
                              height: kFloatingActionButtonTurnInterval,
                              width: kFloatingActionButtonMargin,
                            ),
                      Visibility(
                        visible: state != 0,
                        child: Card(
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Text(
                              'page: ${(state / 20 + 1).round().toString()}'
                                  .capitalize(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ).asGlass(
                            tintColor: Theme.of(context).colorScheme.secondary,
                            tileMode: TileMode.mirror,
                            frosted: false,
                            blurX: 3,
                            blurY: 3,
                            clipBorderRadius: BorderRadius.circular(20)),
                      ),
                      FloatingActionButton.extended(
                        tooltip: 'Next page',
                        // shape: const rectang(),
                        heroTag: 'big_next',
                        shape: state != 0 ? const CircleBorder() : null,
                        isExtended: state == 0,
                        onPressed:
                            isLoading ? null : () => pageCubit.nextPage(),
                        label: const Text('Next'),
                        icon: const Icon(Icons.last_page_sharp),
                      )
                    ],
                  );
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<GetListPokemonCubit, PokemonListState> _listviewBuilder(
      GetListPokemonCubit cubit, PokemonPageCubit pageCubit) {
    return BlocBuilder<GetListPokemonCubit, PokemonListState>(
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
        return const Center(child: Text("Pull down to load Pokémon! ⬇"));
      },
    );
  }

  BlocBuilder<GetListPokemonCubit, PokemonListState> _gridviewBuilder(
      GetListPokemonCubit cubit, PokemonPageCubit pageCubit) {
    return BlocBuilder<GetListPokemonCubit, PokemonListState>(
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
            child: MasonryGridView.builder(
              shrinkWrap: true,
              padding: Paddings.defaultPadding,
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: state.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = state.pokemonList[index];
                return PokemonContainerWiget(pokemon: pokemon.pokemon!);
              },
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          );
        } else if (state is PokemonListError) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text("Pull down to load Pokémon! ⬇"));
      },
    );
  }
}
