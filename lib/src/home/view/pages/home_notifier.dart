import 'package:flutter/material.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/home/domain/usecases/filter_pokemons_usecase.dart';
import 'package:pokedex/src/home/infra/home_repository.dart';

class HomeNotifier extends ValueNotifier<List<PokemonEntity>> {
  final _repository = HomeRepository();
  final _filterUseCase = FilterPokemonsUsecase();

  late List<PokemonEntity> _pokemonsUnfiltered;

  HomeNotifier() : super([]);

  void getPokemons() async {
    final result = await _repository.getPokemons();
    _pokemonsUnfiltered = result;
    value = result;
  }

  void filterPokemons(String text) {
    value = _filterUseCase(_pokemonsUnfiltered, text);
  }
}
