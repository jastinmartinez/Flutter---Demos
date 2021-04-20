import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/coins_breakdown.dart';
import 'package:provider/provider.dart';

class CoinsBreakdownScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final coins = Provider.of<CoinsBreakDown>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Desglose Monedas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF035AA6),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cantidad'),
                  controller: _amountController,
                  validator: ((amount) {
                    if (amount.isEmpty) return 'Digite Cantidad';
                    return null;
                  }),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                  color: Colors.amber,
                  child: Text('Desglosar'),
                  onPressed: () {
                    bool isValidate = _formKey.currentState.validate();
                    if (isValidate)
                      coins.breakdown(
                        int.parse(_amountController.text),
                      );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 600,
                  child: Consumer<CoinsBreakDown>(
                    builder: (context, value, child) => ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) => ListTile(
                        title: Text(
                          value.breakdownResult.keys.elementAt(index),
                        ),
                        subtitle: Text(
                          '\$ ' +
                              value.breakdownResult[value.breakdownResult.keys
                                      .elementAt(index)]
                                  .toString(),
                        ),
                        trailing: Icon(
                          Icons.monetization_on,
                          color: Colors.green,
                        ),
                      ),
                      itemCount: value.breakdownResult.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
