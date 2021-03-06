import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    title: "calculadora de imc",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = "Informe seus dados!";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  void changeRefresh() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void calculoImc() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    double imc = weight / (height * height);

    setState(() {
      if (imc <= 18.5) {
        _infoText = "Abaixo do peso: " + imc.toStringAsPrecision(4);
      } else if (imc > 18.5 && imc <= 24.9) {
        _infoText = "Peso ideal - Parabéns! " + imc.toStringAsPrecision(4);
      } else if (imc > 24.9 && imc <= 29.9) {
        _infoText = "Sobrepeso " + imc.toStringAsPrecision(4);
      } else if (imc > 29.9 && imc <= 34.9) {
        _infoText = "Obesidade Grau I " + imc.toStringAsPrecision(4);
      } else if (imc > 34.9 && imc <= 39.9) {
        _infoText = "Obesidade Grau II " + imc.toStringAsPrecision(4);
      } else {
        _infoText = "Cuidado! Obesidade Grau III ou Mórbida " +
            imc.toStringAsPrecision(4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC",
              style: GoogleFonts.nunito(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: changeRefresh)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                Icon(
                  Icons.account_circle,
                  color: Colors.indigo,
                  size: 120.0,
                ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso(Kg)",
                    labelStyle:
                    GoogleFonts.nunito(color: Colors.indigo, fontSize: 23.0),
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o valor do peso";
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                ),
                TextFormField(

                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(m)",
                      labelStyle: GoogleFonts.nunito(
                          color: Colors.indigo, fontSize: 23.0)),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o valor da altura";
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0, top: 20.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            calculoImc();
                          }
                        },
                        color: Colors.indigo),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(color: Colors.indigo, fontSize: 23.0),
                )
              ],
            ),
          )
        ));
  }
}
