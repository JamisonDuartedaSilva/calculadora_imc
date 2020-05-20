import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const double _nScreenEdgePadding = 20.0;
  static const double _nRbCalcularEdgePadding = 20.0;
  String _infoText = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields()
  {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calculate()
  {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String sImc = imc.toStringAsPrecision(3);

      if (imc < 16.0)
        _infoText = "Magreza grave ($sImc)";
      else if (imc >= 16.0 && imc <= 16.9)
        _infoText = "Magreza moderada ($sImc)";
      else if (imc >= 17.0 && imc <= 18.4)
        _infoText = "Magreza leve ($sImc)";
      else if (imc >= 18.5 && imc <= 24.9)
        _infoText = "Saudavel ($sImc)";
      else if (imc >= 25.0 && imc <= 29.9)
        _infoText = "Sobrepeso ($sImc)";
      else if (imc >= 30.0 && imc <= 34.9)
        _infoText = "Obesidade Grau I ($sImc)";
      else if (imc >= 35.0 && imc <= 39.9)
        _infoText = "Obesidade Grau II ($sImc)";
      else if (imc >= 40.0)
        _infoText = "Obesidade Grau III ($sImc)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {_resetFields();},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        padding: EdgeInsets.only(left: _nScreenEdgePadding, right: _nScreenEdgePadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty)
                    return "Insira seu peso!";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty)
                    return "Insira sua altura!";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: _nRbCalcularEdgePadding, bottom: _nRbCalcularEdgePadding),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: ()
                    {
                      if (_formKey.currentState.validate())
                        _calculate();
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),)
            ],
          ),
        ),
      )
    );
  }
}
