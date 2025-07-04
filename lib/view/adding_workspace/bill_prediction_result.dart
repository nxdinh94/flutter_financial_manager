import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/info_extracted_from_ai_model.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/loading_animation.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/my_box_shadow.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class BillPredictionResult extends StatefulWidget {
  const BillPredictionResult({super.key});

  @override
  State<BillPredictionResult> createState() => _BillPredictionResultState();
}
class _BillPredictionResultState extends State<BillPredictionResult> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, value, child) {
        return LoadingOverlay(
          isLoading: value.loading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("AI prediction result"),
              leading: const CustomBackNavbar(),
              actions: [
                SvgContainer(
                  iconWidth: 22,
                  containerSize: 30,
                  myIconColor: Theme.of(context).colorScheme.secondary,
                  callback: ()async {
                    await context.read<AppViewModel>().billPrediction(context, false);
                  },
                  iconPath: Assets.svgRefresh,
                ),
                const SizedBox(width: 10),
              ],
            ),

            body: Consumer<AppViewModel>(
              builder: (BuildContext context, value, Widget? child) {
                switch(value.infoExtractedFromAi.status){
                  case Status.LOADING:
                    return const Center(child: LoadingAnimation(
                      containerHeight: 200,
                      iconSize: 30,
                    ));
                  case Status.ERROR:
                    return Center(
                      child: Text(value.infoExtractedFromAi.message.toString()),
                    );
                  case Status.COMPLETED:
                    final InfoExtractedFromAiModel data = value.infoExtractedFromAi.data as InfoExtractedFromAiModel;
                    String occurDate = DateTimeHelper.convertDateTimeToString(data.occurDate);
                    return Padding(
                        padding: defaultHalfPadding,
                        child: Column(
                          children: [
                            MyBoxShadow(
                                padding: const EdgeInsets.all(3),
                                child: MyListTitle(
                                  callback: (){},
                                  verticalContentPadding: 4,
                                  leading: Image.asset(data.transactionTypeCategory.icon, width: 30,),
                                  title: data.transactionTypeCategory.name,
                                  titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
                                  subTitle: Text('${data.description.trim()}\n$occurDate'),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MoneyVnd(fontSize: tiny, amount: double.parse(data.amountOfMoney)),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(data.moneyAccount.walletTypeIconPath, width: 30, height: 30),
                                          const SizedBox(width: 6),
                                          Text(data.moneyAccount.name, style: Theme.of(context).textTheme.labelSmall)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: ()async{
                                      await context.push(
                                        FinalRoutes.addingWorkSpacePath, extra: data);},
                                    child: const Text('Update')
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: ()async{
                                      Map<String, dynamic>dataToSubmit = {
                                        'amount_of_money' : data.amountOfMoney,
                                        'transaction_type_category_id' : data.transactionTypeCategory.id,
                                        'occur_date' :  DateTimeHelper.convertDateTimeToIsoString(data.occurDate) ,
                                        'money_account_id' : data.moneyAccount.id,
                                        'description' : data.description,
                                      };
                                      await context.read<TransactionViewModel>().addTransaction(
                                          dataToSubmit, (){context.pop();}, context);
                                    },
                                    child: const Text('Save')
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                    );
                  default:
                    return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
