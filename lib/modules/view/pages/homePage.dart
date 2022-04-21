import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto/modules/controller/controllerPerson.dart';
import 'package:projeto/modules/view/widgets/error.dart';
import 'package:projeto/modules/view/widgets/search.dart';

///class [HomePage] e a class responsavel por mostrar
///ao usuario todos os personagens da serie rick e mory
///a class junto com toda aplicação usa o getx como gerenciador de estado
///pois foi-se aplicado fator de renderização unica para widgets atraves de ids

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// a variavel [_persons] a variavel que instancia como dependencia a class [Persons]
  /// class essa que e a class controller da aplicação
  final Persons _persons = Get.put(Persons());
  // a variavel dio e responsavel por instanciar o pacote DIO que e responsavel pelas requisições http
  final Dio dio = Dio();
  // a variavel url e responsavel por conter o link que sera requisitado pela aplicação
  final String url = "https://rickandmortyapi.com/api/character/";

  //metodo responsavel por inicializar a requisição a url
  @override
  void initState() {
    _persons.getDataPersons(url, dio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// o metodo [GetBuilder] e um metodo do pacote do getx
    /// que e responsavel pela reconstrução e renderização da class [HomePage]
    /// contendo um id HOME que serve como identificador para renderização da class
    return GetBuilder<Persons>(
      init: Persons(),
      id: "home",
      builder: (_) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              /// a class [SearchData] contida no padding e responsavel pela captura
              /// da query que fara a busca dos personagens tanto pelo nome como pelo status
              const Padding(
                padding:
                    EdgeInsets.only(top: 40, bottom: 20, right: 8, left: 8),
                child: SearchData(),
              ),

              /// o metodo [GetBuilder] e o metodo que sera responsavel por retorna
              /// as informação dos personagens caso na requisição nao venha a haver nem
              /// um erro, nesse metodo apresentasse um id PERSONS que e responsavel
              /// para a redenrização da tela apenas nesse metodo fazendo assim
              /// que a renderização da tela nao aconteça de forma unica no metodo
              /// diminuindo assim os recursos de hardware consumidos na renderização da tela
              GetBuilder<Persons>(
                id: "persons",
                builder: (_) => _.proxTela

                    /// a varivel proxTela e uma variavel observavel para verificação da requisição
                    /// pois assim que a requisição venha a ser feita e apresentado um widget
                    /// [CircularProgressIndicator] que mostrará um circulo indicando que a requisição ja foi feita
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )

                    /// a variavel _error e uma variavel observavel responsavel para verificação de erros
                    /// durante a requisição pois caso venha haver um error a tratativa ira verificar
                    /// a natureza do error, retornado uma classe que retorna um widget apresentando o error
                    /// caso contrario sera reconstruida a tela com as informações vinda da API
                    : _.error
                        ? const ErrorPerson()
                        //as informações dessa parte do codigo estao documentadas na class controller [Persons]
                        : Expanded(
                            child: ListView.builder(
                              itemCount: _.dataPerons.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          _.showInforPerson(context, index)),
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black26),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: './imagens/01.jpeg',
                                              image: _.dataPerons[index].image,
                                              fadeInDuration:
                                                  const Duration(seconds: 2),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _.dataPerons[index].name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: _.dataPerons[index]
                                                              .status ==
                                                          "Alive"
                                                      ? Colors.green
                                                      : _.dataPerons[index]
                                                                  .status ==
                                                              "Dead"
                                                          ? Colors.red
                                                          : Colors.amber,
                                                  size: 15,
                                                ),
                                                Text(
                                                  " ${_.dataPerons[index].status} - ${_.dataPerons[index].species}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
                                              "Last known location:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white54,
                                              ),
                                            ),
                                            Text(
                                              _.dataCopi[index].location,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
