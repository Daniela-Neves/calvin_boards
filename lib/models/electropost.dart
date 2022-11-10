class Electropost {
  final int id;
  final String nome;
  final String informacoes;
  final String endereco;
  final String telefone;
  final List<String>? conectores;

  Electropost(
      this.id,
      this.nome,
      this.informacoes,
      this.endereco,
      this.telefone,
      this.conectores);

  Electropost.fromJson(Map json)
      :
        id = json['id'],
        nome = json['nome'],
        informacoes = json['informacoes'],
        endereco = json['endereco'],
        telefone = json['telefone'],
        conectores = json['conectores'].cast<String>();
}

