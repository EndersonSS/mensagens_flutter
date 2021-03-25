import 'package:flutter/material.dart';
import 'package:mensagens/provider/mensagensProvider.dart';
import 'package:mensagens/screens_mensagens/menuMensagens.dart';
import 'package:mensagens/screens_mensagens/screenMensagensArquivadas.dart';
import 'package:mensagens/screens_mensagens/screenMensagensLidas.dart';
import 'package:mensagens/screens_mensagens/screenMensagensNovas.dart';
import 'package:mensagens/utils/appRoutes.dart';
import 'package:provider/provider.dart';

import 'screens_mensagens/lerMensagem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mensagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mensagens(),
    );
  }
}

class Mensagens extends StatefulWidget {
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => new MensagensProvider())
        ],
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.red[400],
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              AppRoutes.MenuMensagens: (ctx) => MenuMensagens(),
              AppRoutes.ScreenMensagensNovas: (ctx) => ScreenMensagensNovas(),
              AppRoutes.ScreenMensagensLidas: (ctx) => ScreenMensagensLidas(),
              AppRoutes.ScreenMensagensArquivadas: (ctx) => ScreenMensagensArquivadas(),
              AppRoutes.LerMensagem: (ctx) => LerMensagem(),
            }));
  }
}
