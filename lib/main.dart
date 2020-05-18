import 'package:flutter/material.dart';
import 'package:flutter/src/material/dialog.dart';

void main(List<String> args) {
  runApp(MaterialApp(title: "Contas Proporcionais", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController venciNomeControl = new TextEditingController();
  TextEditingController venciConjuControl = new TextEditingController();

  TextEditingController nomeControl = new TextEditingController();
  TextEditingController conjugeControl = new TextEditingController();

  TextEditingController nomeContaControl = new TextEditingController();
  TextEditingController valorContaControl = new TextEditingController();

  String nome = "Nome";
  String conjuge = "Conjuge";
  String infoTexto = "";
  double totalNome = 0;

  String strVenciNome = "Vencimento";
  String strVenciConjuge = "Vencimento";
  double totalConjuge = 0;

  List<String> nomes = [];
  List<double> porcentagens = [];
  List<double> vencimentos = [];
  List totalIndividual = new List(3);

  List<double> valorConta = [];
  List<String> nomesContas = [""];
  List<double> valorDividido = [];
  double _totalDespesas = 0;

  double venciNome;
  double venciConjuge;
  var conversor;

  int aux = 0;

  void _mostrarResultados() {
    setState(() {
      print("MOSTRAR RESULTADOS");
      _calcular();
    });
  }

  void _addContas() {
    _salvarDados();
    nomeContaControl.clear();
    valorContaControl.clear();
  }

  void _salvarDados() {
    print("auxii inicio do salvar dados  " + aux.toString());
    if (aux >= 1) {
      nomesContas.insert(aux, nomeContaControl.text);

      print("adicionado nome da conta no valor auxi " + nomesContas[aux]);

      conversor = double.parse(valorContaControl.text);
      valorConta.add(conversor);

      _totalDespesas += conversor;
      aux += 1; //pode colocar no final ta aqui só prateste
    } else {
      venciNome = double.parse(venciNomeControl.text);
      vencimentos.add(venciNome);

      venciConjuge = double.parse(venciConjuControl.text);
      vencimentos.add(venciConjuge);

      nomes.add(nomeControl.text);
      nomes.add(conjugeControl.text);
      double venciTotal = venciNome + venciConjuge;

      porcentagens.add(venciNome * 100 / venciTotal / 100);

      porcentagens.add(venciConjuge * 100 / venciTotal / 100);

      nomesContas.insert(aux, nomeContaControl.text);

      double conversor = double.parse(valorContaControl.text);
      _totalDespesas += conversor;

      valorConta.add(conversor);
      _mudarLabel();
      aux += 1;
    }
  }

  void _calcular() {
    totalNome = 0;
    totalConjuge = 0;
    for (var i = 0; i < 1; i++) {
      print(nomes[i].toUpperCase());
      for (var x = 0; x < aux; x++) {
        valorDividido.insert(x, valorConta[x] * porcentagens[0]);
        totalNome += valorDividido[x];

        print("Conta --> " +
            nomesContas[x] +
            " Valor a ser pago " +
            valorDividido[x].toStringAsPrecision(3));
      }
    }

    print("-----" * 10);

    for (var i = 0; i < 1; i++) {
      print(nomes[1].toUpperCase());
      for (var x = aux; x < aux + aux; x++) {
        valorDividido.insert(x, valorConta[x - aux] * porcentagens[1]);
        totalConjuge += valorDividido[x];

        print("Conta --> " +
            nomesContas[x - aux] +
            " Valor a ser pago " +
            valorDividido[x].toStringAsPrecision(3));
      }
    }

    print("-----" * 10);
    _mudarLabel();
  }

  void infoText() {
    infoTexto = "adicionado a conta na posição $aux";
  }

  void _reset() {
    setState(() {
      venciNomeControl.clear();
      nomeControl.clear();

      conjugeControl.clear();
      venciConjuControl.clear();

      nomeContaControl.clear();
      valorContaControl.clear();

      nome = "Nome";
      conjuge = "Conjuge";

      aux = 0;
    });
  }

  void _mudarLabel() {
    setState(() {
      nome = (porcentagens[0] * 100).toStringAsPrecision(3) + "" + " %";
      conjuge = (porcentagens[1] * 100).toStringAsPrecision(3) + "" + " %";
      if (totalConjuge > 0) {
        strVenciNome = "Total R\$:" + totalNome.toStringAsPrecision(3);
        strVenciConjuge = "Total R\$:" + totalConjuge.toStringAsPrecision(3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: Text(
          "Calculadora do Casal",
          style: TextStyle(color: Colors.yellow[400]),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.yellow[400], size: 30),
              onPressed: _reset)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 20),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.all_inclusive,
                size: 90,
                color: Colors.yellow[600],
              ),
              Row(
                // NOME PRINCIPAL
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextField(
                        cursorColor: Colors.black87,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87)),
                            labelText: nome,
                            labelStyle: TextStyle(
                                fontSize: 20, color: Colors.yellow[500])),
                        controller: nomeControl,
                      ),
                    ),
                  ),

                  SizedBox(width: 50), //NOME CONJUGE
                  Flexible(
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: Colors.black87),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: TextField(
                            textAlign: TextAlign.start,
                            cursorColor: Colors.black87,
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black87)),
                              labelText: strVenciNome,
                              labelStyle: TextStyle(
                                  color: Colors.yellow[500], fontSize: 20),
                            ),
                            controller: venciNomeControl,
                          ),
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 10),
                  Flexible(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.black87),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black87,
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87)),
                            labelText: conjuge,
                            labelStyle: TextStyle(
                                color: Colors.yellow[500], fontSize: 20)),
                        controller: conjugeControl,
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Flexible(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.black87),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: TextField(
                          cursorColor: Colors.black87,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black87)),
                              labelText: strVenciConjuge,
                              labelStyle: TextStyle(
                                  color: Colors.yellow[500], fontSize: 20)),
                          controller: venciConjuControl,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    disabledColor: Colors.black54,
                    onPressed: null,
                    child: Text(""),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.black87),
                      child: TextField(
                        cursorColor: Colors.black87,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87)),
                            labelText: "        Conta",
                            labelStyle: TextStyle(
                                color: Colors.yellow[500], fontSize: 20)),
                        controller: nomeContaControl,
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Flexible(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.black87),
                      child: TextField(
                        cursorColor: Colors.black87,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87)),
                            labelText: "          Valor",
                            labelStyle: TextStyle(
                                color: Colors.yellow[500], fontSize: 20)),
                        controller: valorContaControl,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    onPressed: _addContas,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: _mostrarResultados,
                    child: Text(
                      "Resultado",
                      style: TextStyle(color: Colors.yellow[500], fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
