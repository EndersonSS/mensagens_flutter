import 'dart:convert';

List<Mensagens> mensagensFromMap(String str) => List<Mensagens>.from(
    json.decode(str).map((x) => Mensagens.fromMap(x)));

String mensagensToMap(List<Mensagens> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Mensagens {
  Mensagens({
    required this.qdeMsgnovas,
    required this.qdeMsgarquivadas,
    required this.mensagens,
  });

  int? qdeMsgnovas;
  int? qdeMsgarquivadas;
  List<TipoMensagem>? mensagens;

  factory Mensagens.fromMap(Map<dynamic, dynamic> json) => Mensagens(
    qdeMsgnovas: json["qde_msgnovas"] == null ? null: int.parse(json["qde_msgnovas"]),
    qdeMsgarquivadas: json["qde_msgarquivadas"] == null ? null : int.parse(json["qde_msgarquivadas"]),
    mensagens: json["mensagens"] == null ? null : List<TipoMensagem>.from(json["mensagens"].map((x) => TipoMensagem.fromMap(x))),
    
    );

  Map<String, dynamic> toMap() => {
        "qde_msgnovas": qdeMsgnovas == null ? null : qdeMsgnovas,
        "qde_msgarquivadas": qdeMsgarquivadas == null ? null : qdeMsgarquivadas,
        "mensagens": mensagens == null ? null : List<dynamic>.from(mensagens!.map((x) => x.toMap())),
      };
}

class TipoMensagem {
  TipoMensagem(
      {required this.codigo,
      required this.de,
      required this.para,
      required this.datahora,
      required this.titulo,
      required this.conteudo,
      required this.status,
      this.isCheck = false});

   int? codigo;
   String? de;
   String? para;
   DateTime? datahora;
   String? titulo;
   String? conteudo;
   int? status;

  bool isCheck;


  factory TipoMensagem.fromMap(Map<dynamic, dynamic> json) => TipoMensagem(
        codigo: json["codigo"] == null ? null : int.parse(json["codigo"]),
        de: json["de"] == null ? null : json["de"],
        para: json["para"] == null ? null : json["para"],
        datahora:
            json["datahora"] == null ? null : DateTime.parse(json["datahora"]),
        titulo: json["titulo"] == null ? null : json["titulo"],
        conteudo: json["conteudo"] == null ? null : json["conteudo"],
        status: json["status"] == null ? null : int.parse(json["status"]),
      );

  Map<dynamic, dynamic> toMap() => {
        "codigo": codigo == null ? null : codigo,
        "de": de == null ? null : de,
        "para": para == null ? null : para,
        "datahora": datahora == null ? null : datahora!.toIso8601String(),
        "titulo": titulo == null ? null : titulo,
        "conteudo": conteudo == null ? null : conteudo,
        "status": status == null ? null : status,
      };

  Map<String, dynamic> toMapAtualizaStatus() => {
        "codigo": codigo == null ? null : codigo,
        "status": status == null ? null : status,
      };
}
