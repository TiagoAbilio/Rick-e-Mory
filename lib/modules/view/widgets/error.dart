import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto/modules/controller/controllerPerson.dart';

//class responsavel por retornar o erro tratado na class [Persons] para o usuario
class ErrorPerson extends StatelessWidget {
  const ErrorPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Persons>(
      builder: (_) => Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_.icon, color: Colors.black54, size: 50),
            const SizedBox(
              height: 8,
            ),
            Text(
              _.msg,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
