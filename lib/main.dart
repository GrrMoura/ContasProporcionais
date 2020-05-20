import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String nome = "        Nome";
  String conjuge = "         Conjuge";
  String infoTexto = "";
  double totalNome = 0;

  String strVenciNome = "     Vencimento";
  String strVenciConjuge = "     Vencimento";
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

      nome = "        Nome";
      conjuge = "         Conjuge";

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

  Widget builderTypeString(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: TextField(
          cursorColor: Colors.black87,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black87, fontSize: 20),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              labelText: label,
              labelStyle: TextStyle(
                color: Colors.yellow[500],
                fontSize: 20,
              )),
          controller: controller,
        ));
  }

  Widget builderTypeNumber(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
        padding: EdgeInsets.only(left: 14, right: 10),
        child: TextField(
          cursorColor: Colors.black87,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black87, fontSize: 20),
          decoration: InputDecoration(
              prefix: Text("R\$"),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              labelText: label,
              labelStyle: TextStyle(
                color: Colors.yellow[500],
                fontSize: 20,
              )),
          controller: controller,
        ));
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
                  Flexible(
                    child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: builderTypeString(nome, nomeControl)),
                  ),

                  //NOME CONJUGE
                  Flexible(
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.black87),
                          child: builderTypeNumber(
                              strVenciNome, venciNomeControl))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: Colors.black87),
                        child: builderTypeString(conjuge, conjugeControl)),
                  ),
                  Flexible(
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: Colors.black87),
                        child: builderTypeNumber(
                            strVenciConjuge, venciConjuControl)),
                  ),
                ],
              ),
              Divider(),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        disabledColor: Colors.black54,
                        onPressed: null,
                        child: Text(""))
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: builderTypeString("   Conta", nomeContaControl),
                    ),
                  ),
                  Flexible(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: Colors.black87),
                      child: builderTypeNumber("   Valor", valorContaControl),
                    ),
                  ),
                  Flexible(
                      child: Theme(
                    data:
                        Theme.of(context).copyWith(accentColor: Colors.black87),
                    child: RaisedButton(
                        color: Colors.black45,
                        onPressed: _addContas,
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.yellow[400], fontSize: 20),
                        )),
                  ))
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: _mostrarResultados,
                    child: Text(
                      "Calcular",
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
