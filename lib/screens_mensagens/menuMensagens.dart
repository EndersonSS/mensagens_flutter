import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mensagens/model/mensagens.dart';
import 'package:mensagens/provider/mensagensProvider.dart';
import 'package:mensagens/services/servicesMensagens.dart';
import 'package:mensagens/utils/appRoutes.dart';
import 'package:provider/provider.dart';

class MenuMensagens extends StatefulWidget {
  @override
  _MenuMensagensState createState() => _MenuMensagensState();
}

class _MenuMensagensState extends State<MenuMensagens> {
  final streamController = StreamController<List<Mensagens>>();

  @override
  void initState() {
    super.initState();
    future();
  }

  future() {
    ServicesMensagens.carregarMensagensNovas(12).then((value) {
      if (value != null) {
        List<Mensagens> streamMensagensNovas = value;
        streamController.add(streamMensagensNovas);
      } else {
        List<Mensagens> streamMensagensNovas = [];
        streamController.add(streamMensagensNovas);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MensagensProvider msg = Provider.of(context);

    var appBar = AppBar();
    var size = MediaQuery.of(context).size;

    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mensagens", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight * 1,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    _atualizaQdeMsg(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mark_email_unread_sharp,
                            color: Colors.red[400]),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Mensagens Novas",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                      ),
                      Container(
                          height: 25,
                          width: 25,
                          decoration: new BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                          ),
                          child: StreamBuilder(
                              stream: streamController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.error != null) {
                                  return Container(
                                    height: 25,
                                    width: 25,
                                    decoration: new BoxDecoration(
                                      color: Colors.red[400],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text('0',
                                            style: TextStyle(
                                                color: (Colors.white),
                                                fontSize: 18)),
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      itemCount: snapshot.data != null
                                          ? snapshot.data.length
                                          : 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        msg.setQdeMsgnovas =
                                            snapshot.data[index].qdeMsgnovas;
                                        msg.setQdeMsgArquivadas = snapshot
                                            .data[index].qdeMsgarquivadas;

                                        return Container(
                                          height: 25,
                                          width: 25,
                                          decoration: new BoxDecoration(
                                            color: Colors.red[400],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              child: Text(
                                                  msg.getQdeMsgnovas.toString(),
                                                  style: TextStyle(
                                                      color: (Colors.white),
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }))
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.blueGrey[100],
                  height: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.ScreenMensagensLidas);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mark_email_read_sharp,
                            color: Colors.red[400]),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Mensagens Lidas",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.blueGrey[100],
                  height: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.ScreenMensagensArquivadas);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[50],
                          shape: BoxShape.circle,
                        ),
                        child:
                            Icon(Icons.move_to_inbox, color: Colors.red[400]),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Mensagens Arquivadas",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.255,
                      ),
                      Container(
                          height: 25,
                          width: 25,
                          decoration: new BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(msg.getQdeMsgArquivadas.toString(),
                                  style: TextStyle(
                                      color: (Colors.white), fontSize: 16)),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                child: Divider(
                  thickness: 1.0,
                  color: Colors.blueGrey[100],
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _atualizaQdeMsg(BuildContext context) async {
    MensagensProvider msg = Provider.of(context, listen: false);

    Navigator.of(context).pushNamed(AppRoutes.ScreenMensagensNovas).then((_) {
      msg.atualizar();
      setState(() {
        future();
      });
    });
  }
}
