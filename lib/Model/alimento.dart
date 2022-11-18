const String tableAlimenti= 'alimenti';                 //model alimento

class AlimentoFields{
  static final List<String> values = [
    id,nome,kcal,carbo,grassi,proteine
  ];
  static const String id = '_id';
  static const String nome = 'nome';
  static const String kcal = 'kcal';
  static const String carbo = 'carbo';
  static const String grassi = 'grassi';
  static const String proteine = 'proteine';
  static const String user = 'user';
}

class Alimento {
  final int? id;
  final String nome;
  final int kcal;
  final double carbo;
  final double grassi;
  final double proteine;
  final String user;

  const Alimento({
    this.id,
    required this.nome,
    required this.kcal,
    required this.carbo,
    required this.grassi,
    required this.proteine,
    required this.user,
  });

  Alimento copy({
    int? id,
    String? nome,
    int? kcal,
    double? carbo,
    double? grassi,
    double? proteine,
    String? user,
  }) =>
      Alimento(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        kcal: kcal ?? this.kcal,
        carbo: carbo ?? this.carbo,
        grassi: grassi ?? this.grassi,
        proteine: proteine ?? this.proteine,
        user: user ?? this.user,
      );

  Map<String, dynamic> toMap() {
    return {
      AlimentoFields.id: id,
      AlimentoFields.nome: nome,
      AlimentoFields.kcal: kcal,
      AlimentoFields.carbo: carbo,
      AlimentoFields.grassi: grassi,
      AlimentoFields.proteine: proteine,
      AlimentoFields.user: user,
    };
  }



  static Alimento fromMap(Map<String, Object?> json) => Alimento(
    id: json[AlimentoFields.id] as int?,
    nome: json[AlimentoFields.nome] as String,
    kcal: json[AlimentoFields.kcal] as int,
    carbo: json[AlimentoFields.carbo] as double,
    grassi: json[AlimentoFields.grassi] as double,
    proteine: json[AlimentoFields.proteine] as double,
    user: json[AlimentoFields.user].toString(),
  );
}



