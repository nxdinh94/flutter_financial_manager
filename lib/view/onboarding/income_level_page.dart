import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/common_widget/my_box_shadow.dart';
import 'package:flutter/material.dart';
import '../../constants/padding.dart';
import '../common_widget/custom_textfield.dart';
import '../common_widget/prefix_icon_amount_textfield.dart';

class IncomeLevelPage extends StatefulWidget {
  const IncomeLevelPage({super.key, required this.callback});
  final void Function(String) callback;

  @override
  State<IncomeLevelPage> createState() => _IncomeLevelPageState();
}

class _IncomeLevelPageState extends State<IncomeLevelPage> {
  final TextEditingController _amountController = TextEditingController();
  bool flag = false;
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: (){
            String amount = _amountController.text;
            if(amount.isEmpty || amount == '0'){
              Utils.flushBarErrorMessage('Please, fulfill this field', context);
              return;
            }
            widget.callback(_amountController.text);
          },
          child: const Text('Next')
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us about your monthly income',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              MyBoxShadow(
                padding: defaultHalfPadding,
                child: CustomTextfield(
                  controller: _amountController,
                  textInputType: TextInputType.number,
                  prefixIcon: const PrefixIconAmountTextfield(),
                  fontSize: 40,
                  hintText: '0',
                  prefixIconPadding: const EdgeInsets.only(right: 11, left: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
