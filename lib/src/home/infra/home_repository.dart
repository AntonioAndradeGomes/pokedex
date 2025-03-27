import 'package:pokedex/src/home/data/home_datasource.dart';
import 'package:pokedex/src/home/domain/entities/pokemon_entity.dart';

class HomeRepository {
  final _datasource = HomeDatasource();
  Future<List<PokemonEntity>> getPokemons() {
    return _datasource.getPokemons();
  }
}
