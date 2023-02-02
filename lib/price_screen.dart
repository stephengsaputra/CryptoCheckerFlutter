import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  double coinValue;

  void initState() {
    super.initState();
    this.updateUI();
  }

  void updateUI() async {
    try {
      var data = await CoinData().getData(selectedCurrency);
      setState(() {
        coinValue = double.parse((data['rate']).toStringAsFixed(2));
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  // List<Widget> cryptoCard() {
  //   List<Widget> widgets = [];
  //
  //   for (String crypto in cryptoList) {
  //     var card = Padding(
  //       padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
  //       child: Card(
  //         color: Colors.lightBlueAccent,
  //         elevation: 5.0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
  //           child: Text(
  //             '1 $crypto = ? $selectedCurrency',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 20.0,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //
  //     widgets.add(card);
  //   }
  //
  //   return widgets;
  // }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      pickerItems.add(item);
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateUI();
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 BTC = ${coinValue == null ? '?' : coinValue} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ]),
          Container(
            height: 200.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
