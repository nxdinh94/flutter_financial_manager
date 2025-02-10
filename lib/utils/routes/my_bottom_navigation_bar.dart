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
          }
        },
        currentIndex: widget.child.currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded, size: 24),
            label: 'Transactions',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.wallet_outlined,
              size: 26,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
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
