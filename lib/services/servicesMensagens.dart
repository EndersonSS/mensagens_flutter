import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mensagens/model/mensagens.dart';

class ServicesMensagens {
  static Future<List<Mensagens>?> carregarMensagensNovas(
      lkVendedor) async {
    List<Mensagens> mensagensNovas;

    final String url = '';

    final credentials = '';
    final stringToBase64 = utf8.fuse(base64);
    final encodedCredentials = stringToBase64.encode(credentials);

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $encodedCredentials",
    };
    final response = await http.get(Uri.parse(url), headers: header);
    //  print(response.statusCode);
    //  print(response.body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listaResponse = data['mensagens_novas'];

      mensagensNovas = <Mensagens>[];

      if (listaResponse.isNotEmpty) {
        // mensagensNovas.clear();
        for (Map map in listaResponse) {
          Mensagens msg = Mensagens.fromMap(map);
          mensagensNovas.add(msg);
        }
      } else {
        return [];
      }
    } else {
      return null;
    }
    return mensagensNovas;
  }

  Future<List<Mensagens>?> carregarMensagensLidas(
      lkVendedor, mensagensLidas) async {
    final String url = '';

    final credentials = '';
    final stringToBase64 = utf8.fuse(base64);
    final encodedCredentials = stringToBase64.encode(credentials);

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $encodedCredentials",
    };
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listaResponse = data['mensagens_lidas'];
      if (listaResponse.isNotEmpty) {
        mensagensLidas.clear();
        for (Map map in listaResponse) {
          Mensagens msg = Mensagens.fromMap(map);
          mensagensLidas.add(msg);
        }
      } else {
        return [];
      }
    } else {
      return null;
    }
    return mensagensLidas;
  }

  Future<List<Mensagens>?> carregarMensagensArquivadas(
      lkVendedor, mensagensArquivadas) async {
    final String url =
        '';

    final credentials = '';
    final stringToBase64 = utf8.fuse(base64);
    final encodedCredentials = stringToBase64.encode(credentials);

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $encodedCredentials",
    };
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List listaResponse = data['mensagens_arquivadas'];
      if (listaResponse.isNotEmpty) {
        mensagensArquivadas.clear();
        for (Map map in listaResponse) {
          Mensagens msg = Mensagens.fromMap(map);
          mensagensArquivadas.add(msg);
        }
      } else {
        return [];
      }
    } else {
      return null;
    }
    return mensagensArquivadas;
  }

  Future<dynamic> atualizandoStatusMsg(listStatus) async {
    final String url = '';

    final credentials = '';
    final stringToBase64 = utf8.fuse(base64);
    final encodedCredentials = stringToBase64.encode(credentials);

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $encodedCredentials",
    };

    var _body = json.encode(listStatus);

    print("Json enviado : $_body");

    var response = await http.put(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var resultado = json.decode(response.body);
    if (response.statusCode == 200) {
      if (resultado['result'] == "status mensagem alterado") {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }
}
