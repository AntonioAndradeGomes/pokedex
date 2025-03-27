import 'package:flutter/material.dart';
import 'package:pokedex/src/home/view/pages/home_notifier.dart';
import 'package:pokedex/src/home/view/widgets/pokemon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  final _notifier = HomeNotifier();

  @override
  void initState() {
    super.initState();
    _notifier.getPokemons();

    _textController.addListener(() {
      _notifier.filterPokemons(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.grey,
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Search Pokemon',
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _notifier,
        builder: (_, state, __) {
          if (state.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (_, index) {
              final pokemon = state[index];
              return PokemonWidget(
                key: ValueKey(pokemon.pokemonId),
                pokemon: pokemon,
              );
            },
          );
        },
      ),
    );
  }
}
