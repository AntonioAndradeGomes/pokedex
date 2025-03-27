import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String pokemonName;
  final String pokemonId;

  const PokemonEntity({required this.pokemonName, required this.pokemonId});

  @override
  List<Object?> get props => [pokemonName, pokemonId];
}
