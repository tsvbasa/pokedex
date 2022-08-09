import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo_pokedex/models/pokemon_model.dart';
import 'package:flutter_codigo_pokedex/ui/widgets/item_pokemon_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Uri permite identificar a este recurso y tb localizarlo
  List pokemons = [];
  List<PokemonModel> pokemonsModel = [];

  @override
  initState() {
    super.initState();
    getDataPokemon();
  }

  getDataPokemon() async {
    Uri _uri = Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      // pokemons = myMap["pokemon"];
      pokemonsModel = myMap["pokemon"].map<PokemonModel>((e)=>PokemonModel.fromJson(e)).toList();
      // print(pokemonsModel);
      setState(() {});
      // pokemons.forEach((element) {
      //   print(element["type"]);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Pokedex",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                GridView.count(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  children: pokemonsModel
                      .map(
                        (e) => ItemPokemonWidget(
                          pokemon: e,
                          // name: e.name,
                          // image: e.img,
                          // types: e.type,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
