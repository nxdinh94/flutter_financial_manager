import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/custom_textfield.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final TextEditingController _nameController = TextEditingController();
  final List<bool> _selectedToggleItem = <bool>[true, false];
  final List<String> transactionTypeId = <String>['e2443bef-0715-4e06-b55e-fddcf018127a', 'a4c18d24-e41f-4a69-8547-1548ce81db43'];
  final List<Widget> categoriesType = <Widget>[const Text('Income'), const Text('expense')];
  String selectedTransactionTypeId = '';
  String iconPath = '';
  PickedIconModel pickedParentIconCategory = PickedIconModel(icon: '', name: '', id: '');


  Future<void> _onSelectParentCategory(PickedIconModel pickedIcon) async {
    setState(() {
      pickedParentIconCategory = pickedIcon;
    });
    context.pop();
  }

  @override
  void initState() {
    selectedTransactionTypeId = transactionTypeId[0];
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
        leading: const CustomBackNavbar(),
      ),
      floatingActionButton: MyFloatActionButton(
        callback: (){
          if(_nameController.text.isEmpty || iconPath.isEmpty){
            Utils.flushBarErrorMessage('Name and icon are required', context);
            return; 
          }
          Map<String, dynamic> data = {
            "transaction_type_id": selectedTransactionTypeId,
            "icon": iconPath,
            "name": _nameController.text,
          };
          if(pickedParentIconCategory.id.isNotEmpty){
            data['parent_id'] = pickedParentIconCategory.id;
          }else{
            data.remove('parent_id');
          }

        }
      ),
      body: Padding(
        padding: defaultPadding,
        child: Container(
          padding: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: horizontalHalfPadding,
                child: CustomTextfield(
                  controller: _nameController,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(6),
                    width: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: GestureDetector(
                      onTap: ()async{
                        dynamic path = await context.push(
                          FinalRoutes.pickIconPathForCategoryPath,
                        );
                        if(!mounted) return;
                        if(path != null){
                          setState(() {
                            iconPath = path;
                          });
                        }
                      },
                      child: Image.asset(
                        iconPath.isEmpty ? 'assets/another_icon/question-mark.png' : iconPath, width: 36, height: 36,
                      ),
                    ),
                  ),
                  hintText: 'Category Name',
                  fontSize: extraBigger,
                  prefixIconPadding: const EdgeInsets.only(right: 12),
                ),
              ),
              const SizedBox(height: 12),
              MyDivider(),
              Padding(
                padding: defaultHalfPadding,
                child: Row(
                  children: [
                    SvgContainer(
                      iconWidth: 24,
                      containerSize: 32,
                      iconPath: Assets.svgMathematical
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 35,
                      child: ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < _selectedToggleItem.length; i++) {
                              _selectedToggleItem[i] = i == index;
                            }
                            selectedTransactionTypeId = transactionTypeId[index];
                          });
                        },
                        direction: Axis.horizontal,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        selectedColor: colorTextWhite,
                        fillColor: secondaryColor,
                        color: colorTextLabel,
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        constraints: const BoxConstraints(minHeight: 40.0, minWidth: 80.0),
                        isSelected: _selectedToggleItem,
                        children: categoriesType,
                      ),
                    ),
                  ],
                ),
              ),
              MyDivider(),
              Container(
                padding: horizontalHalfPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyListTitle(
                  callback: ()async{
                    context.push(
                      FinalRoutes.selectParentCategories,
                      extra: {
                        'selectedTransactionTypeId': selectedTransactionTypeId,
                        'onTap': _onSelectParentCategory,
                      }
                    );
                  },
                  title: 'Parent Category',
                  titleTextStyle: Theme.of(context).textTheme.labelSmall!,
                  subTitle: Text(
                    pickedParentIconCategory.name.isEmpty ? 'Select category' : pickedParentIconCategory.name,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: big)),
                  leading: SvgContainer(
                    iconWidth: 30,
                    iconPath: Assets.svgBoxWithUpArrow,
                  ),
                  leftContentPadding: 0,
                  rightContentPadding: 0,
                  verticalContentPadding: -1,
                  trailingCallback: pickedParentIconCategory.id.isEmpty ? null : (){
                    setState(() {
                      pickedParentIconCategory = PickedIconModel(icon: '', name: '', id: '');
                    });
                  },
                  // minConstraintSize: 20,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
