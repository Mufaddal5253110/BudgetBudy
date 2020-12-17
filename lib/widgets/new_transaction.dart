import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTran;

  NewTransaction(this.addTran);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();
  final inputAmountController = TextEditingController();
  DateTime _selectedDate;

  void chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Titile"),
              //onChanged: (value) => inputTitle = value,
              controller: inputTitleController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              //onChanged: (value) => inputAmount = value,
              controller: inputAmountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text(_selectedDate != null
                    ? DateFormat.yMMMd().format(_selectedDate)
                    : "No Date Choosen Yet!"),
                FlatButton(
                  child: Text(
                    "Choose Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    chooseDate();
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text("Add"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () {
                final enteredTitle = inputTitleController.text;
                final enteredAmount = double.parse(inputAmountController.text);
                if (enteredTitle.isNotEmpty ||
                    enteredAmount <= 0 ||
                    _selectedDate == null) {
                  widget.addTran(
                      enteredTitle, enteredAmount, _selectedDate);
                  //Navigator.of(context).pop();
                  inputTitleController.clear();
                  inputAmountController.clear();
                  setState(() {
                    _selectedDate = null;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
