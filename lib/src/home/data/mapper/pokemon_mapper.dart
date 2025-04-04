import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';

class PokemonMapper {
  static Map<String, dynamic> toJson(PokemonEntity pokemon) {
    return {
      'pokemonId': pokemon.pokemonId,
      'pokemonName': pokemon.pokemonName,
      'pokemonUrl': pokemon.pokemonUrl,
    };
  }

  static PokemonEntity fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      pokemonId: json['pokemonId'],
      pokemonName: json['pokemonName'],
      pokemonUrl: json['pokemonUrl'],
    );
  }
}
