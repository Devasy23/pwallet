// File: views/accounts_page.dart
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  final List<Map<String, dynamic>> accounts = [
    {'type': 'Savings Account', 'balance': 5000.00},
    {'type': 'Checking Account', 'balance': 1500.00},
    {'type': 'Investment Account', 'balance': 12000.00},
    // Add more accounts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts Overview'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildAccountsList(),
          _buildAddAccountButton(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAccountsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          var account = accounts[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(account['type']),
              subtitle: Text('\$${account['balance'].toStringAsFixed(2)}'),
              leading: Icon(Icons.account_balance_wallet),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddAccountButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          // Implement navigation or functionality for adding a new account
        },
        child: Text('Add New Account'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Background color
          foregroundColor: Colors.white, // Text color
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Accounts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: 'Debts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Analysis',
        ),
      ],
      selectedItemColor: Colors.amber[800],
    );
  }
}
