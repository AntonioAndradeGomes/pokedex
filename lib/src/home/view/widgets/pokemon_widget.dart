import 'package:flutter/material.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';

class PokemonWidget extends StatelessWidget {
  final PokemonEntity pokemon;
  const PokemonWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(pokemon.pokemonName));
  }
}
