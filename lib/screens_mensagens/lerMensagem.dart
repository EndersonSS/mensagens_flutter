import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mensagens/model/mensagens.dart';

class LerMensagem extends StatefulWidget {
  @override
  _LerMensagemState createState() => _LerMensagemState();
}

class _LerMensagemState extends State<LerMensagem> {
  @override
  Widget build(BuildContext context) {
    final mensagens =
        ModalRoute.of(context)!.settings.arguments as TipoMensagem;

    var appBar = AppBar();
    var size = MediaQuery.of(context).size;

    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

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
        title: Text("Mensagem"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.red[400],
      ),
      body: SingleChildScrollView(
        child: Container(
            height: screenHeight * 1,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mensagens.titulo!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Text(
                          "${formatDate(mensagens.datahora!, [
                            dd,
                            '/',
                            mm,
                            '/',
                            yyyy
                          ])}",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                ),
                Container(
                  height: screenHeight * 0.76,
                  child:
                      Text(mensagens.conteudo!, style: TextStyle(fontSize: 18)),
                ),
              ],
            )),
      ),
    );
  }
}
