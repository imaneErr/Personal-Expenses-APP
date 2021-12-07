import 'package:flutter/material.dart';
import 'package:tp2/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'Transact1',
    //   title: 'Object1',
    //   amount: 125.50,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'Transact2',
    //   title: 'Object2',
    //   amount: 160,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTranasciton(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTranasciton),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.pink.shade100,
        title: Text(
          'Personal Expanses',
          style: TextStyle(
            fontFamily: 'Open Sans',
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add)),
        ],
      ),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children:<Widget> [
      //     Container(
      //       height: 600,
      //       child: SingleChildScrollView(
      //         child: Column(
      //           //mainAxisAlignment: MainAxisAlignment.start, //Vertical
      //           crossAxisAlignment: CrossAxisAlignment.stretch, // Horizantal
      //           children: <Widget>[
      //             Chart(_recentTransactions),
      //             TransactionList(_userTransactions)
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      //
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: <Widget>[
      //     Container(
      //       height: 100,
      //       child: Text('Item 1'),
      //       color: Colors.red,
      //     ),
      //     Expanded(
      //       flex: 5,
      //       // fit: FlexFit.tight,
      //       child: Container(
      //         height: 100,
      //         width: 100,
      //         child: Text('Item 2'),
      //         color: Colors.blue,
      //       ),
      //     ),
      //     Flexible(
      //       flex: 1,
      //       fit: FlexFit.loose,
      //       child: Container(
      //         height: 100,
      //         child: Text('Item 3'),
      //         color: Colors.orange,
      //       ),
      //     ),
      //   ],
      // ),

      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction)
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}