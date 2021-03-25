import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:mensagens/componentes/shimmerWidgetMensagens.dart';
import 'package:mensagens/componentes/showLoadingIndicator.dart';
import 'package:mensagens/model/mensagens.dart';
import 'package:mensagens/provider/mensagensProvider.dart';
import 'package:flutter/material.dart';
import 'package:mensagens/utils/appRoutes.dart';
import 'package:provider/provider.dart';

class ScreenMensagensArquivadas extends StatefulWidget {
  @override
  _ScreenMensagensArquivadasState createState() =>
      _ScreenMensagensArquivadasState();
}

class _ScreenMensagensArquivadasState extends State<ScreenMensagensArquivadas> {
  final streamController = StreamController<List<Mensagens>>();

  bool visibleOpcoesAppBar = false;

  bool isCheckd = false;

  @override
  void initState() {
    super.initState();
    future();
  }

  future() {
    Provider.of<MensagensProvider>(context, listen: false)
        .getMensagensArquivadas()
        .then((value) {
      if (value != null) {
        List<Mensagens> streamMensagensArquivadas = value;
        streamController.add(streamMensagensArquivadas);
      } else {
        List<Mensagens> streamMensagensArquivadas = [];
        streamController.add(streamMensagensArquivadas);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var size = MediaQuery.of(context).size;

    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    MensagensProvider msg = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.all(9.0),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.red[400],
                    size: 25,
                  ),
                ),
              ),
            ),
            centerTitle: true,
            title: Text("Arquivadas"),
            backgroundColor: Colors.red[400],
            actions: [
              Visibility(
                visible: visibleOpcoesAppBar,
                child: Row(
                  children: [
                    IconButton(
                      icon: isCheckd == false
                          ? Icon(Icons.check_box_outline_blank,
                              color: Colors.blueGrey[300])
                          : Icon(Icons.check_box, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          if (isCheckd = !isCheckd) {
                            for (int i = 0;
                                i < msg.mensagensArquivadas.length;
                                i++) {
                              msg.mensagensArquivadas[i].isCheck = true;
                            }
                          } else {
                            for (int i = 0;
                                i < msg.mensagensArquivadas.length;
                                i++) {
                              msg.mensagensArquivadas[i].isCheck = false;
                            }
                            visibleOpcoesAppBar = false;
                            isCheckd = false;
                          }
                        });
                      },
                    ),
                    IconButton(
                        tooltip: "Deletar mensagens",
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () => apagandoMensagem()),
                  ],
                ),
              ),
            ]),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: streamController.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: ShimmerWidgetMensagens());
                    }
                    if (snapshot.error != null) {
                      return Text('Ocorreu um erro');
                    }
                    if (snapshot.data.isEmpty) {
                      return Center(child: Text("Sem Mensagens Arquivadas"));
                    } else {
                      return ListView.builder(
                          itemCount:
                              snapshot.data != null ? snapshot.data.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            msg.setQdeMsgnovas =
                                snapshot.data[index].qdeMsgnovas;
                            msg.setQdeMsgArquivadas =
                                snapshot.data[index].qdeMsgarquivadas;
                            final item = snapshot.data[index];
                            msg.mensagensArquivadas = item.mensagens;
                            return item.mensagens.isEmpty
                                ? Container(
                                    height: screenHeight * 1,
                                    child: Center(
                                        child:
                                            Text("Sem Mensagens Arquivadas")))
                                : Container(
                                    height: screenHeight * 1,
                                    child: ListView.builder(
                                        itemCount: item.mensagens != null
                                            ? item.mensagens.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final aq = item.mensagens[index];
                                          return Card(
                                            elevation: 12,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    AppRoutes.LerMensagem,
                                                    arguments: aq);
                                              },
                                              child: ListTile(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      aq.status == 0
                                                          ? Text(
                                                              aq.titulo,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              maxLines: 1,
                                                            )
                                                          : Text(
                                                              aq.titulo,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                              maxLines: 1,
                                                            ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.60,
                                                      ),
                                                      Container(
                                                          width: 35,
                                                          child: Checkbox(
                                                            value: aq.isCheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                aq.isCheck =
                                                                    value;
                                                                addListaSelelcionados();
                                                              });
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${formatDate(aq.datahora, [
                                                                dd,
                                                                '/',
                                                                mm,
                                                                '/',
                                                                yyyy
                                                              ])}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18)),
                                                          aq.status == 0
                                                              ? Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  height: 10,
                                                                  width: 25,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ))
                                                              : Container(),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        aq.conteudo,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                        maxLines: 2,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "${formatDate(aq.datahora, [
                                                            HH,
                                                            ':',
                                                            nn
                                                          ])}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          );
                                        }),
                                  );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  apagandoMensagem() async {
    MensagensProvider msg = Provider.of(context, listen: false);

    DialogBuilder(context).showLoadingIndicator("Apagando mensagem");
    msg.alterarStatusMensagensArquivadas(2).then((value) {
      DialogBuilder(context).hideOpenDialog();
      if (value == false) {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alerta!'),
            content: Text("Ocorreu ao apagar mensagem"),
            actions: [
              TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          ),
        );
      } else if (value == true) {
        setState(() {
          future();
          visibleOpcoesAppBar = false;
          isCheckd = false;
        });
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alerta!'),
            content: Text("Mensagem apagada"),
            actions: [
              TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          ),
        );
      } else {
        return Text('Ocorreu um erro!');
      }
    });
  }

  void addListaSelelcionados() {
    MensagensProvider msg = Provider.of(context, listen: false);
    setState(() {
      var contain =
          msg.mensagensArquivadas.where((element) => element.isCheck == true);
      if (contain.isEmpty) {
        visibleOpcoesAppBar = false;
        isCheckd = false;
      }
      if (contain.length == 1) {
        visibleOpcoesAppBar = true;
        isCheckd = false;
      }
      if (contain.length == msg.mensagensArquivadas.length) {
        isCheckd = true;
      }
    });
  }
}
