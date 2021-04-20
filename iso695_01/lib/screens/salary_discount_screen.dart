import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iso695_01/Logic/salary_discount.dart';
import 'package:provider/provider.dart';

class SalaryDiscountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final callFunction = Provider.of<SalaryDiscount>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Descuento Salario'),
        backgroundColor: const Color(0xFF035AA6),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Salario'),
                controller: _salaryController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(7),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (salary) {
                  if (salary.isEmpty) {
                    return 'Digite Salario';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    callFunction.salaryDiscount(
                      double.parse(_salaryController.text),
                    );
                  }
                },
                child: Text('Calcular'),
                color: Colors.amber,
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<SalaryDiscount>(
                builder: (ctx, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => ListTile(
                    title:
                        Text(value.salaryDiscountResult.keys.elementAt(index)),
                    subtitle: Text(
                      '\$' +
                          value.salaryDiscountResult[value
                                  .salaryDiscountResult.keys
                                  .elementAt(index)]
                              .toString(),
                    ),
                  ),
                  itemCount: value.salaryDiscountResult.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
