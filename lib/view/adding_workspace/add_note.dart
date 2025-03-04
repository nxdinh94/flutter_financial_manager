import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.note});
  final String note;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final TextEditingController _noteController = TextEditingController();
  String textTyped = '';
  @override
  void initState() {
    textTyped = widget.note;
    _noteController.text = textTyped;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        leading: CustomBackNavbar(
          value: textTyped,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        height: screenHeight,
        child: TextField(
          controller: _noteController,
          onChanged: (String e) {
            setState(() {
              textTyped = e;
            });
          },
          decoration: InputDecoration(
            hintText: 'Add Note',
          ),
          maxLines: null,
          autofocus: true,
          cursorColor: colorTextBlack,
        ),
      ),
    );
  }
}
