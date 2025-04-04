import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/src/home/data/mapper/pokemon_mapper.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pokemonKeyName = 'pokemonKeyName';

class HomeDatasource {
  final Dio _dio = Dio();
  Future<List<PokemonEntity>> getPokemons() async {
    final prefs = await SharedPreferences.getInstance();

    final pokemonsCached = prefs.getStringList(pokemonKeyName);

    if (pokemonsCached != null) {
      return pokemonsCached
          .map((e) => PokemonMapper.fromJson(jsonDecode(e)))
          .toList();
    }

    final pokemonFeatures = await Future.wait([
      _getPokemonsRange(1, 40),
      _getPokemonsRange(40, 80),
      _getPokemonsRange(80, 120),
      _getPokemonsRange(120, 151),
    ]);

    final reducedPokemons = pokemonFeatures.reduce(
      (value, element) => value + element,
    );

    await prefs.setStringList(
      pokemonKeyName,
      reducedPokemons.map((e) => jsonEncode(PokemonMapper.toJson(e))).toList(),
    );

    return reducedPokemons;
  }

  Future<List<PokemonEntity>> _getPokemonsRange(int start, int end) async {
    final List<PokemonEntity> pokemons = [];

    for (int i = start; i < end; i++) {
      final pokemon = await _getPokemonById(i.toString());
      if (pokemon != null) {
        pokemons.add(pokemon);
      }
    }

    return pokemons;
  }

  Future<PokemonEntity?> _getPokemonById(String pokemonId) async {
    try {
      final result = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon/$pokemonId',
      );

      return PokemonEntity(
        pokemonName: result.data['name'],
        pokemonId: pokemonId,
        pokemonUrl: result.data["sprites"]["front_default"],
      );
    } on DioException catch (err, s) {
      return null;
    }
  }
}
