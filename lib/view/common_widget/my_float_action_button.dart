import 'package:flutter/material.dart';
class MyFloatActionButton extends StatelessWidget {
  const MyFloatActionButton({
    super.key,
    this.label = 'Save',
    required this.callback
  });
  final String label;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width -32,
      height: 35,
      child: FloatingActionButton.extended(
        onPressed: callback,
        label: Text(label, style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.w500
        ),),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
