const String tableDiari= 'diari';               //Model diario

class DiarioFields{
  static final List<String> values = [
    id,pasto,alimento,giorno,utente
  ];
  static const String id = '_id';
  static const String pasto= 'pasto';
  static const String alimento = 'alimento';
  static const String quantita = 'quantita';
  static const String giorno = 'giorno';
  static const String utente = 'utente';
}

class Diario {
  final int? id;
  final String pasto;
  final int alimento;
  double quantita;
  final String giorno;
  final String utente;

  Diario({
    this.id,
    required this.pasto,
    required this.alimento,
    required this.quantita,
    required this.giorno,
    required this.utente,
  });

  Diario copy({
    int? id,
    String? pasto,
    int? alimento,
    double? quantita,
    String? giorno,
    String? utente,
  }) =>
      Diario(
        id: id ?? this.id,
        pasto: pasto ?? this.pasto,
        alimento: alimento ?? this.alimento,
        quantita: quantita ?? this.quantita,
        giorno: giorno ?? this.giorno,
        utente: utente ?? this.utente,
      );

  Map<String, dynamic> toMap() {
    return {
      DiarioFields.id: id,
      DiarioFields.pasto: pasto,
      DiarioFields.alimento: alimento,
      DiarioFields.quantita: quantita,
      DiarioFields.giorno: giorno,
      DiarioFields.utente: utente,
    };
  }


  static Diario fromMap(Map<String, Object?> json) => Diario(
    id: json[DiarioFields.id] as int?,
    pasto: json[DiarioFields.pasto] as String,
    alimento: json[DiarioFields.alimento] as int,
    quantita: json[DiarioFields.quantita] as double,
    giorno: json[DiarioFields.giorno].toString(),
    utente: json[DiarioFields.utente].toString(),
  );
}