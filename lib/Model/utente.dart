class Utente{           //Model Utente
  String email;
  String nome;
  String cognome;
  String stile;
  String sesso;
  int altezza;
  double peso;
  int eta;
  int kcal;
  double carbo;
  double grassi;
  double proteine;


  Utente({
    required this.email,
    required this.nome,
    required this.cognome,
    required this.stile,
    required this.sesso,
    required this.altezza,
    required this.peso,
    required this.eta,
    required this.kcal,
    required this.carbo,
    required this.grassi,
    required this.proteine,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'stile': stile,
      'sesso': sesso,
      'altezza': altezza,
      'peso': peso,
      'eta': eta,
      'kcal': kcal,
      'carbo': carbo,
      'grassi': grassi,
      'proteine': proteine
    };
  }

  static Utente fromMap(Map<String, Object?> json) => Utente(
    email: json['email'] as String,
    nome: json['nome'] as String,
    cognome: json['cognome'] as String,
    stile: json['stile'] as String,
    sesso: json['sesso'] as String,
    altezza: json['altezza'] as int,
    peso: json['peso'] as double,
    eta: json['eta'] as int,
    kcal: json['kcal'] as int,
    carbo: json['carbo'] as double,
    grassi: json['grassi'] as double,
    proteine: json['proteine'] as double,
  );
}