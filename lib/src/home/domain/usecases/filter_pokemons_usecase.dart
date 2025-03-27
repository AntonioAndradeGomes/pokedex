import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';

class FilterPokemonsUsecase {
  List<PokemonEntity> call(List<PokemonEntity> pokemonList, String filterText) {
    return pokemonList
        .where((element) => _hasName(element, filterText))
        .toList();
  }

  bool _hasName(PokemonEntity pokemon, String filterText) {
    return pokemon.pokemonName.toLowerCase().contains(filterText.toLowerCase());
  }
}
