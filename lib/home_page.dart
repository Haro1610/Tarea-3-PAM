// ignore_for_file: deprecated_member_use

import 'donativos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentSelectedRadio;
  var assetsRadioGroup = {
    0: "assets/paypal.png",
    1: "assets/credit-card.png",
  };
  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };

  int paypal = 0;
  int creditCard = 0;

  _radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioItem) => ListTile(
            leading: Image.asset(
              assetsRadioGroup[radioItem.key]!,
              height: 64,
              width: 44,
            ),
            title: Text(radioItem.value),
            trailing: Radio(
              value: radioItem.key,
              groupValue: currentSelectedRadio,
              onChanged: (int? newSelectedRadio) {
                currentSelectedRadio = newSelectedRadio!;
                setState(() {});
              },
            ),
          ),
        )
        .toList();
  }

  mapear() {
    return {
      0: paypal,
      1: creditCard,
    };
  }

  // TODO: completar metodo para generar los DropDownMenuItems
  // Es posible utilizar .map como en la de los radios}
  int drop = 0;
  double porcentajeDonacion = 0;
  double porcentajeAcululado = 0;
  var donationAmout = [0, 100, 350, 850, 1050, 9999];

  dropDownItemsGenerator(arr) {
    return arr.map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text("$value"),
      );
    }).toList();
  }

  // TODO: metodo para calcular las donaciones
  // identifica si la donacion es por paypal o tarjeta
  // utiliza datos de los radio buttons y drop down

  double limite() {
    if ((porcentajeDonacion + porcentajeAcululado) < 1) {
      return ((porcentajeDonacion + porcentajeAcululado) * 100); //* 100);
    } else {
      return 100;
    }
  }

  Widget _donationIndicator() {
    return (Column(
      children: [
        LinearProgressIndicator(
            color: Colors.purple,
            backgroundColor: Colors.grey,
            minHeight: 20,
            value: porcentajeDonacion + porcentajeAcululado),
        Text("${limite().toStringAsFixed(2)} %"),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                currentSelectedRadio == 0 ? paypal += drop : creditCard += drop;
                porcentajeAcululado = paypal / 10000;
                porcentajeDonacion = creditCard / 10000;
              },
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.purple,
            minimumSize: const Size.fromHeight(35),
          ),
          child: Text("DONAR"),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            // Radios paypal y tarjeta
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _radioGroupGenerator(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cantidad a donar:"),
                DropdownButton<int>(
                  value: drop,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      drop = newValue!;
                      //porcentajeDonacion = drop / 10000;
                      //porcentajeAcululado = drop / 10000;
                    });
                  },
                  items: dropDownItemsGenerator(donationAmout),
                  // TODO: Agregar DropdownButton en el trailing
                  // utilizar el metodo dropDownItemsGenerator() para pasar
                  // como parametro a "items" del DropdownButton
                ),
              ],
            ),
            _donationIndicator()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        tooltip: "Ver donativos",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donativos(
                donativos: mapear(),
              ),
            ),
          );
        },
      ),
    );
  }
}
