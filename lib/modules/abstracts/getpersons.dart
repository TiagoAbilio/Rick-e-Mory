import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// class responsavel pelas assinaturas da class seguindo assim
/// o principio da inversão de dependencia, fazendo com que
/// a aplicação nao venha a denpender de implementações e sim de abstrações
abstract class GetPersons {
  getDataPersons(String url, Dio dio);
  searchPersons(String query);
  Widget showInforPerson(BuildContext context, int index);
}
