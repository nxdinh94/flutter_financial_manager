import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:flutter/material.dart';
class EmptyValueScreen extends StatelessWidget {
  const EmptyValueScreen({
    super.key,
    this.iconSize = 100,
    this.isAccountPage = false,
    required this.title,
  });

  final double iconSize;
  final bool isAccountPage;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: defaultPadding,
        child: Column(
          children: [
            Image.asset('assets/another_icon/grey-coin.png', width: iconSize),
            const SizedBox(height: 12,),
            Text(title,style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 6,),
            Visibility(
              visible: isAccountPage,
              child: GestureDetector(
                onTap: (){

                },
                child: RichText(
                    text: const TextSpan(
                        text: '+',
                        style: TextStyle(color: primaryColor, fontSize: 22),
                        children: [
                          TextSpan(text: 'Thêm tài khoản', style:  TextStyle(
                              color: primaryColor, fontSize: normal
                          ))
                        ]
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
