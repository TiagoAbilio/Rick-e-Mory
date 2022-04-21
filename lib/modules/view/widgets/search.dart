import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto/modules/controller/controllerPerson.dart';

//class responsavel por capturar os dados de teclado para pesquisa de personagens
class SearchData extends StatefulWidget {
  const SearchData({Key? key}) : super(key: key);

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  //a variavel _controller e responsavel para tratativa de informações vinda do usuario
  final TextEditingController _controller = TextEditingController();
  // a varivel _personsController e responsavel por retorna a instancia contida na memoria da classController Persons
  final Persons _personsController = Get.find<Persons>();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      //as informações dessa parte do codigo estao documentadas na class controller [Persons]
      onChanged: (value) => _personsController.searchPersons(value),
      decoration: const InputDecoration(
        hintText: 'Searching...',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
