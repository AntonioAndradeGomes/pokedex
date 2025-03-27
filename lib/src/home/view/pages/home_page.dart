import 'package:flutter/material.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/home/infra/home_repository.dart';
import 'package:pokedex/src/home/view/widgets/pokemon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  List<PokemonEntity> pokemons = [];
  List<PokemonEntity> pokemonsFiltered = [];

  @override
  void initState() {
    super.initState();
    HomeRepository().getPokemons().then((value) {
      setState(() {
        pokemons = value;
        pokemonsFiltered = value;
      });
    });

    _textController.addListener(onChangedText);
  }

  void onChangedText() {
    setState(() {
      pokemonsFiltered =
          pokemons.where((element) {
            return element.pokemonName.toLowerCase().contains(
              _textController.text.toLowerCase(),
            );
          }).toList();
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
      body:
          pokemonsFiltered.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: pokemonsFiltered.length,
                itemBuilder: (_, index) {
                  final pokemon = pokemonsFiltered[index];
                  return PokemonWidget(pokemon: pokemon);
                },
              ),
    );
  }
}
