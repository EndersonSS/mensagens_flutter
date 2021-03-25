import 'package:flutter/material.dart';
import 'package:mensagens/model/mensagens.dart';
import 'package:mensagens/services/servicesMensagens.dart';

class MensagensProvider with ChangeNotifier {
  final servicesMensagens = ServicesMensagens();

  List<Mensagens> mensagens = [];

  List<TipoMensagem> mensagensNovas = [];

  List<TipoMensagem> mensagensLidas = [];

  List<TipoMensagem> mensagensArquivadas = [];

  List<TipoMensagem>? listTmpMsg = [];

  List<TipoMensagem> listTmpMsgLidas = [];

  int qdeMsgnovas = 0;
  int qdeMsgArquivadas = 0;

  int get getQdeMsgnovas => this.qdeMsgnovas;

  set setQdeMsgnovas(int qdeMsgnovas) {
    this.qdeMsgnovas = qdeMsgnovas;
  }

  int get getQdeMsgArquivadas => this.qdeMsgArquivadas;

  set setQdeMsgArquivadas(int qdeMsgArquivadas) {
    this.qdeMsgArquivadas = qdeMsgArquivadas;
  }

  void atualizar() {
    getQdeMsgArquivadas;
    getQdeMsgnovas;
    notifyListeners();
  }

  Future<bool> alterarStatusMensagensNovas(status) async {
    var newAddItem;

    listTmpMsg = [];

    newAddItem = null;

    mensagensNovas.forEach((element) async {
      if (element.isCheck == true) {
        newAddItem = TipoMensagem(
            codigo: element.codigo,
            status: status,
            conteudo: element.conteudo,
            de: element.de,
            datahora: element.datahora,
            para: element.para,
            titulo: element.titulo);
        listTmpMsg!.add(newAddItem);
      } else {
        return null;
      }
    });

    Map<String, dynamic> mapMensagem = {
      "mensagens": listTmpMsg == null
          ? null
          : List<dynamic>.from(listTmpMsg!.map((x) => x.toMapAtualizaStatus())),
    };

    if (newAddItem != null) {
      var result = await servicesMensagens.atualizandoStatusMsg(mapMensagem);
      return result;
    } else {
      return false;
    }
  }

  Future<bool> alterarStatusMensagensLidas(status) async {
    var newAddItem;

    listTmpMsg = [];
    newAddItem = null;

    mensagensLidas.forEach((element) async {
      if (element.isCheck == true) {
        newAddItem = TipoMensagem(
            codigo: element.codigo,
            status: status,
            conteudo: element.conteudo,
            de: element.de,
            datahora: element.datahora,
            para: element.para,
            titulo: element.titulo);
        listTmpMsg!.add(newAddItem);
      } else {
        return null;
      }
    });

    Map<String, dynamic> mapMensagem = {
      "mensagens": listTmpMsg == null
          ? null
          : List<dynamic>.from(listTmpMsg!.map((x) => x.toMapAtualizaStatus())),
    };

    if (newAddItem != null) {
      var result = await servicesMensagens.atualizandoStatusMsg(mapMensagem);
      return result;
    } else {
      return false;
    }
  }

  Future<bool> alterarStatusMensagensArquivadas(status) async {
    var newAddItem;

    listTmpMsg = [];
    newAddItem = null;

    mensagensArquivadas.forEach((element) async {
      if (element.isCheck == true) {
        newAddItem = TipoMensagem(
            codigo: element.codigo,
            status: status,
            conteudo: element.conteudo,
            de: element.de,
            datahora: element.datahora,
            para: element.para,
            titulo: element.titulo);
        listTmpMsg!.add(newAddItem);
      } else {
        return null;
      }
    });

    Map<String, dynamic> mapMensagem = {
      "mensagens": listTmpMsg == null
          ? null
          : List<dynamic>.from(listTmpMsg!.map((x) => x.toMapAtualizaStatus())),
    };

    if (newAddItem != null) {
      var result = await servicesMensagens.atualizandoStatusMsg(mapMensagem);
      return result;
    } else {
      return false;
    }
  }

  Future<bool> alterarMengensNovasLidas(codigoMsg) async {
    var newAddItem;

    listTmpMsg = [];
    newAddItem = null;

    print(newAddItem);

    mensagensNovas.forEach((element) async {
      if (element.codigo == codigoMsg) {
        newAddItem = TipoMensagem(
            codigo: element.codigo,
            status: 1,
            conteudo: element.conteudo,
            de: element.de,
            datahora: element.datahora,
            para: element.para,
            titulo: element.titulo);
        listTmpMsg!.add(newAddItem);
      } else {
        return null;
      }
    });

    Map<String, dynamic> mapMensagem = {
      "mensagens": listTmpMsg == null
          ? null
          : List<dynamic>.from(listTmpMsg!.map((x) => x.toMapAtualizaStatus())),
    };
    print(newAddItem);

    if (newAddItem != null) {
      var result = await servicesMensagens.atualizandoStatusMsg(mapMensagem);
      return result;
    } else {
      return false;
    }
  }

  getMensagensNovas() => mensagens =
      ServicesMensagens.carregarMensagensNovas(12) as List<Mensagens>;

  getMensagensLidas() =>
      servicesMensagens.carregarMensagensLidas(12, mensagens);

  getMensagensArquivadas() =>
      servicesMensagens.carregarMensagensArquivadas(12, mensagens);
}
