Uma aplicação que faz integração utilizando o Graphql, onde possivel  buscar os personagens tanto pelo nome quanto pelo status

Observação.: Devido a utilização do plugin url launcher para a abertura de links utilizando o navegador, tal poderá a vim apresentar erro nativo no plugin,
caso venha a se fazer teste emulando no navegador basta retirar o plugin url_launcher no pubspec.yaml, e retirar a funcao async apresentada no metodo showInforPerson na class Persons tal funcao apresenta-se no 6ª Align com essa condificação.
"
6ª -> Align(
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
"

RETIRA

"
async {
                          if (await canLaunch(
                              dataPerons[index].episode[indexinterno])) {
                            await launch(
                                dataPerons[index].episode[indexinterno],
                                forceWebView: false,
                                forceSafariVC: false);
                          }
                        },
                        
Pois tal e responsavel pelo envio de links e abertura do navegador                        
"

caso o codigo seja compilado no propio aparelho ou no emulador android nao a necessidade
de alterações
