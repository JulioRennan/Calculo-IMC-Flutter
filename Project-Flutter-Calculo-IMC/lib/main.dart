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
  TextEditingController pesoControl = TextEditingController();
  TextEditingController alturaControl = TextEditingController();
  String _info ="Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _resetaTela(){

      pesoControl.text ="";
      alturaControl.text="";
      setState(() {
        _info = "Informe seus dados";
        _formKey = GlobalKey<FormState>();
      });

  }
  void _calcule(){
    setState(() {
      double peso = double.parse(pesoControl.text);
      double altura = double.parse(alturaControl.text)/100;
      double imc = peso/(altura*altura);
      if(imc<18.6){
        _info = "Abaixo do peso(${imc.toStringAsPrecision(3)})";

      }else{
        _info = "Nao esta desnutrido(${imc.toStringAsPrecision(3)})";
      }
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
              onPressed: _resetaTela,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20),
                  controller: pesoControl,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira Seu Peso";
                    }
                  },
                ),



                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20),
                  controller: alturaControl,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira Sua Altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calcule();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20),


                )
              ],
            ),
          )
        ));
  }
}
