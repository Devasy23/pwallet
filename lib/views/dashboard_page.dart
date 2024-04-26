import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'accounts_page.dart';

String userName = 'User';
double totalBalance = 1000.0;
double inflow = 500.0;
double outflow = 200.0;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
    '/dashboard': (context) => DashboardPage(),
    '/accounts': (context) => AccountsPage(),
    // '/transactions': (context) => TransactionsPage(), // Define this page
    // '/debts': (context) => DebtsPage(), // Define this page
    // '/analysis': (context) => AnalysisPage(), // Define this page
  },
        home: Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildTopSection(),
          _buildMiddleSection(),
          _buildBottomSection(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    ));
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello, $userName',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          Text(
            'Total Balance: \$${totalBalance.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.green.shade400),
              Text(
                'Inflow: \$${inflow.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.green.shade400),
              ),
              Spacer(),
              Icon(Icons.arrow_downward, color: Colors.red.shade400),
              Text(
                'Outflow: \$${outflow.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.red.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Transaction ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Details of Transaction ${index + 1}'),
            isThreeLine: true,
          );
        },
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              foregroundColor: Colors.white, // Text color
              shadowColor: Colors.blueAccent, // Shadow color
              elevation: 8,
            ),
            child: Text('Add Income'),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Button color
              foregroundColor: Colors.white, // Text color
              shadowColor: Colors.redAccent, // Shadow color
              elevation: 8,
            ),
            child: Text('Add Expense'),
          ),
        ],
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
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
  if (_selectedIndex != index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name != '/dashboard') {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
        break;
      case 1:
        if (ModalRoute.of(context)?.settings.name != '/accounts') {
          Navigator.pushReplacementNamed(context, '/accounts');
        }
        break;
      // case 2:
      //   if (ModalRoute.of(context)?.settings.name != '/transactions') {
      //     Navigator.pushReplacementNamed(context, '/transactions');
      //   }
      //   break;
      // case 3:
      //   if (ModalRoute.of(context)?.settings.name != '/debts') {
      //     Navigator.pushReplacementNamed(context, '/debts');
      //   }
      //   break;
      // case 4:
      //   if (ModalRoute.of(context)?.settings.name != '/analysis') {
      //     Navigator.pushReplacementNamed(context, '/analysis');
      //   }
      //   break;
    }
  }
}

}
