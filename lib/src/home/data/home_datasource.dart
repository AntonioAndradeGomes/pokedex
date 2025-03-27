import 'package:dio/dio.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';

class HomeDatasource {
  final Dio _dio = Dio();
  Future<List<PokemonEntity>> getPokemons() async {
    final result = await _dio.get(
      'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20',
    );
    final pokemons =
        (result.data['results'] as List).map((e) {
          return PokemonEntity(pokemonName: e['name'], pokemonId: e['name']);
        }).toList();
    return pokemons;
  }
}
