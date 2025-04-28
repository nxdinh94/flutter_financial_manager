import 'package:fe_financial_manager/constants/transaction_type_id.dart';
import 'package:fe_financial_manager/model/transaction_categories_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../constants/colors.dart';
import '../../generated/assets.dart';
import '../../generated/paths.dart';
import '../../model/picked_icon_model.dart';
import '../../view_model/app_view_model.dart';
import '../common_widget/custom_back_navbar.dart';
import '../common_widget/custom_textfield.dart';
import '../common_widget/divider.dart';
import '../common_widget/my_list_title.dart';
import '../common_widget/svg_container.dart';

class EditCategories extends StatefulWidget {
  const EditCategories({super.key, required this.pickedCategory});
  final PickedIconModel pickedCategory;

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late PickedIconModel parentCategory;
  String iconPath = '';
  Future<void> _onSave ()async {
    Map<String, dynamic> data = {
      'id': widget.pickedCategory.id,
      'name': _nameController.text,
      'icon': iconPath,
      'parent_id': parentCategory.id,
      'transaction_type_id': transactionTypeId[1],
    };
    if(data['parent_id'].toString().isEmpty){
      data.remove('parent_id');
    }
    await context.read<AppViewModel>().updateTransactionCategoriesApi(data, context);
  }
  Future<void> _onDelete ()async {
    await context.read<AppViewModel>().deleteTransactionCategoriesApi(widget.pickedCategory.id, context);
  }
  Future<void> _onSelectParentCategory(PickedIconModel pickedIcon) async {
    setState(() {
      parentCategory = pickedIcon;
    });
    context.pop();
  }

  PickedIconModel? _findParentCategory(List<CategoriesIconModel> icons, String iconId) {
    for (final parent in icons) {
      for (final child in parent.children) {
        if (child.id == iconId) {
          return PickedIconModel(id: parent.id, name: parent.name, icon: parent.icon);
        }
      }
    }
    return null;
  }


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.pickedCategory.name;
    iconPath = widget.pickedCategory.icon;
    final expenseIcons = context.read<AppViewModel>().iconCategoriesData.data?.categoriesIconListMap['expense'] ?? [];
    parentCategory = _findParentCategory(expenseIcons, widget.pickedCategory.id) ?? PickedIconModel(icon: '', name: '', id: '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dividerIndent = screenHeight * 0.094;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
        leading: const CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _IconPickerField(
              controller: _nameController,
              iconPath: iconPath,
              callback: ()async{
                dynamic path = await context.push(
                  FinalRoutes.pickIconPathForCategoryPath,
                );
                if(!mounted) return;
                if(path != null){
                  setState(() {
                    iconPath = path;
                  });
                }
              }
            ),
            MyDivider(indent: dividerIndent),
            _ParentCategorySelector(
              parentCategory: parentCategory,
              callback: () => context.push(FinalRoutes.selectParentCategories,  extra: {
                'selectedTransactionTypeId': transactionTypeId[1],
                'onTap': _onSelectParentCategory,
              }),
            ),
            const SizedBox(height: 12),
            // _DescriptionField(controller: _descriptionController),
            // const SizedBox(height: 20),
            _ActionButtons(
              deleteAction: _onDelete,
              saveAction: _onSave,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Icon Picker ----------------
class _IconPickerField extends StatelessWidget {
  final TextEditingController controller;
  final String iconPath;
  final VoidCallback callback;

  const _IconPickerField({
    required this.controller,
    required this.iconPath,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: controller,
      hintText: 'Name',
      prefixIcon: GestureDetector(
        onTap: callback,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, width: 40),
            Text(
              'Pick icon',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: secondaryColor),
            ),
          ],
        ),
      ),
      prefixIconPadding: const EdgeInsets.only(right: 6, left: 12),
      verticalPadding: 6,
    );
  }
}

// ---------------- Parent Category Selector ----------------
class _ParentCategorySelector extends StatelessWidget {
  final PickedIconModel parentCategory;
  final VoidCallback callback;
  const _ParentCategorySelector({required this.parentCategory, required this.callback});

  @override
  Widget build(BuildContext context) {
    String iconPath = 'assets/another_icon/wallet.png';
    String iconName = 'None';
    if(parentCategory.id.isNotEmpty){
      iconPath = parentCategory.icon;
      iconName = parentCategory.name;
    }
    return MyListTitle(
      callback: callback,
      title: 'Pick parent category',
      titleTextStyle: Theme.of(context).textTheme.labelSmall!,
      subTitle: Text(iconName, style: Theme.of(context).textTheme.bodyLarge),
      leading: Image.asset(iconPath, width: 40),
      leftContentPadding: 16,
      horizontalTitleGap: 10,
    );
  }
}

// ---------------- Description Field ----------------
class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const _DescriptionField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: controller,
      textInputType: TextInputType.text,
      prefixIcon: SvgContainer(
        iconWidth: 32,
        iconPath: Assets.svgTextAlignLeft,
        containerSize: 38,
      ),
      hintText: 'Description',
      verticalPadding: 6,
      prefixIconPadding: const EdgeInsets.only(right: 10, left: 18),
    );
  }
}

// ---------------- Save & Delete Buttons ----------------
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.saveAction, required this.deleteAction});
  final VoidCallback saveAction;
  final VoidCallback deleteAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: deleteAction,
            style: ButtonStyle(
              side: WidgetStateProperty.all(
                const BorderSide(color: emergencyColor),
              ),
            ),
            child: const Text(
              'DELETE', style: TextStyle(color: emergencyColor),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: saveAction,
            child: const Text('SAVE'),
          ),
        ),
      ],
    );
  }
}
