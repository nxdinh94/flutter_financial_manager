import 'package:fe_financial_manager/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int count  = 0;
  bool isInAddingTab = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );

          if(index == 1){
            setState(() {
              count++;
            });
          }
          // refresh ui whenever go through favorite tab
          if(index == 2){
            setState(() {
              isInAddingTab = true;
            });
          }else{
            setState(() {
              isInAddingTab = false;
            });
          }
        },
        currentIndex: widget.child.currentIndex,
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 10
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            key: const ValueKey('homeTabButton'),
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            key: ValueKey('transactionsTabButton'),
            icon: Icon(Icons.account_balance_wallet_rounded, size: 24),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            key: const ValueKey('addWorkspaceTabButton'),
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 45,
                height: 45,
                color: isInAddingTab ?
                  Theme.of(context).colorScheme.secondary : iconColor ,
                child: Icon(
                  Icons.add,
                  size: 26,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            key: const ValueKey('budgetsTabButton'),
            icon: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_bag),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            label: 'Budgets',
          ),
          const BottomNavigationBarItem(
            key: ValueKey('accountTabButton'),
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
