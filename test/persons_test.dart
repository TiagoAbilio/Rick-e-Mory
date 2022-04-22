import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/modules/controller/controllerPerson.dart';

void main() {
  final repository = Persons();
  const String url = "https://rickandmortyapi.com/api/character/";
  final Dio dio = Dio();

  test(
      "teste de requisição de uma lista de persons verificando se retorna null",
      () async {
    final list = await repository.getDataPersons(url, dio);
    expect(list == null, equals(true));
  });

  test('verificando se foi introduzido dados na lista do dataPerson', () async {
    await repository.getDataPersons(url, dio);
    final data = repository.dataPerons;
    expect(data.isNotEmpty, equals(true));
  });

  test('verificando se o primeiro nome da list de dataPerson e Rick Sanchez',
      () async {
    await repository.getDataPersons(url, dio);
    final data = repository.dataPerons;
    expect(data[0].name.contains("Rick Sanchez"), equals(true));
  });

  test(
      'verificando se o metodo searchPersons fara a atualizacao da lista dataPersons quando for passada uma query',
      () async {
    await repository.getDataPersons(url, dio);
    final atual = repository.dataPerons.length;
    await repository.searchPersons("Rick Sanchez");
    final depois = repository.dataPerons.length;
    expect(atual != depois, equals(true));
  });

  test(
      'verificando se o metodo searchPersons fara a atualizacao da lista dataPersons quando nao passada nem uma query',
      () async {
    await repository.getDataPersons(url, dio);
    final atual = repository.dataPerons.length;
    await repository.searchPersons("");
    final depois = repository.dataPerons.length;
    expect(atual != depois, equals(false));
  });
}
