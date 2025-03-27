import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String pokemonName;
  final String pokemonId;
  final String pokemonUrl;

  const PokemonEntity({
    required this.pokemonName,
    required this.pokemonId,
    required this.pokemonUrl,
  });

  @override
  List<Object?> get props => [pokemonName, pokemonId, pokemonUrl];
}
