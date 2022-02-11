import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  Map donativos;
  Donativos({Key? key, required this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  var donativos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal.png"),
              trailing: Text(
                "${widget.donativos[0]}.0",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/credit-card.png"),
              trailing: Text(
                "${widget.donativos[1]}.0",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "${widget.donativos[0] + widget.donativos[1]}.0",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            Container(
              child: (widget.donativos[0] + widget.donativos[1]) < 10000
                  ? null
                  : Image.asset("assets/ventana.png"),
            )

            // TODO: mostrar imagen de "Gracias" solo si se ha logrado la meta de 10,000 en donaciones
          ],
        ),
      ),
    );
  }
}
