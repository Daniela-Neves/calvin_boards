class SignUp {
  int? id;
  String nome;
  int celular;
  DateTime data;
  String email;
  String senha;

  SignUp({
    this.id,
    required this.nome,
    required this.celular,
    required this.email,
    required this.data,
    required this.senha,
  });
}
