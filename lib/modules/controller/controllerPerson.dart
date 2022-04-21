import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto/modules/abstracts/getpersons.dart';
import 'package:projeto/modules/models/data.dart';
import 'package:url_launcher/url_launcher.dart';

// class resposnavel pelo controller da aplicação
class Persons extends GetxController implements GetPersons {
  //varivel responsavel por guarda um vetor de objetos
  List<DataPerson> dataPerons = [];
  //varivel responsavel por guarda uma copia do vetor de objetos
  List<DataPerson> dataCopi = [];

  //variavel observavel responsavel para a mudança de tela e indicação de requisição de dados na internet
  bool _proxTela = false;
  bool get proxTela => _proxTela;

  ///varivel responsavel para a tratativa de error
  /// retornando um bool caso venha a acontecer um erro durante a requisição dos dados
  bool _erro = false;
  bool get error => _erro;

  ///varivel responsavel pela msg de erro
  ///tal se apresenta iniciada com uma mensagem
  ///mais sendo tratada durante a tratativa de erros
  String _msg = "Verifique sua conexão com a internet";
  String get msg => _msg;

  /// varivel reponsavel por retorna um icone na class [ErrorPerson]
  /// class responsavel pela apresentação de erros durante a requisição
  ///tal se apresenta iniciada com um icone
  ///mais sendo tratada durante a tratativa de erros
  IconData _icon = Icons.wifi_off_rounded;
  IconData get icon => _icon;

  /// metodo responsavel pela requisição dos dados vinda da api
  /// sao passadas como parametros a url de requisição
  /// e uma instancia do DIO
  @override
  getDataPersons(String url, Dio dio) async {
    try {
      //varivel que e responsavel por chama o circuleprogrssindicador na [HomePage]
      _proxTela = true;
      //funcao responsavel por chama a rendenrização na class [HomePage] no id persons
      update(['persons']);
      var response = await dio.get(url);
      //mapeamento e inclusao dos dados vindo da api nas variaveis [dataPerons,dataCopi]
      response.data['results'].map((value) {
        dataPerons.add(DataPerson.fromMap(value));
        dataCopi.add(DataPerson.fromMap(value));
      }).toList();
      //função usada para da uma pausa de 1s para a nova renderição na class [HomePage]
      Future.delayed(const Duration(seconds: 1), () {
        _proxTela = false;
        _erro = false;
        update(['persons']);
      });
    } on DioError catch (e) {
      /// nessa parte e feita a tratativa de erro, que possa acontecer
      /// durante uma requisição sendo ela DioErrorType.other e DioErrorType.response
      /// renderizando assim a tela e mostrando o error
      Future.delayed(const Duration(seconds: 1), () {
        if (e.type.toString() != "DioErrorType.other") {
          _icon = Icons.warning_amber;
          _msg = "Servidor fora do ar, tente novamente mais tarde";
        }
        _erro = true;
        _proxTela = false;
        update(['persons']);
      });
    }
  }

  ///metodo responsavel por fazer a pesquisa da query dentro da lista de Objetos
  ///retornando assim apenas os Objetos com nome e status digitado
  ///e renderizando a tela com apenas os dados retornados
  @override
  searchPersons(String query) {
    final person = dataCopi.where((element) {
      final nome = element.name.toLowerCase();
      final status = element.status.toLowerCase();
      return nome.contains(query.toLowerCase()) ||
          status.contains(query.toLowerCase());
    }).toList();
    dataPerons = person;
    update(['home']);
  }

  /// metodo responsavel por retornar [BottomSheet] um widget
  /// que mostrará os dados pessoais de cada personagem
  @override
  Widget showInforPerson(BuildContext context, int index) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, -1.3),
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: './imagens/01.jpeg',
                    image: dataPerons[index].image,
                    fadeInDuration: const Duration(seconds: 2),
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(1, -1),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black45,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.7),
                child: Text(
                  dataPerons[index].name,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dataPerons[index].name != ""
                          ? "Nome: ${dataPerons[index].name}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Status: ${dataPerons[index].status} - ",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                        ),
                        Icon(
                          Icons.circle,
                          color: dataPerons[index].status == "Alive"
                              ? Colors.green
                              : dataPerons[index].status == "Dead"
                                  ? Colors.red
                                  : Colors.amber,
                          size: 15,
                        ),
                      ],
                    ),
                    Text(
                      dataPerons[index].species != ""
                          ? "Espécie: ${dataPerons[index].species}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      dataPerons[index].gender != ""
                          ? "Gênero: ${dataPerons[index].gender}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      dataPerons[index].origin != ""
                          ? "Origem: ${dataPerons[index].origin}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      dataPerons[index].origin != ""
                          ? "Total episódios: ${dataPerons[index].episode.length}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      dataPerons[index].type != ""
                          ? "Tipo espécie: ${dataPerons[index].type}"
                          : "",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment(0, 0.35),
                child: Text(
                  "Links Para Episodios",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 1),
                child: SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataPerons[index].episode.length,
                    itemBuilder: (context, indexinterno) {
                      return GestureDetector(
                        onTap: () async {
                          if (await canLaunch(
                              dataPerons[index].episode[indexinterno])) {
                            await launch(
                                dataPerons[index].episode[indexinterno],
                                forceWebView: false,
                                forceSafariVC: false);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: './imagens/01.jpeg',
                                  image: dataPerons[index].image,
                                  fadeInDuration: const Duration(seconds: 2),
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("${indexinterno + 1}")
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
