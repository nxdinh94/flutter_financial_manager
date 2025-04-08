import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/font_size.dart';
import '../../generated/assets.dart';
import '../../generated/paths.dart';
import '../../model/picked_icon_model.dart';
import '../../model/transaction_categories_icon_model.dart';
import '../../data/response/status.dart';
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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.pickedCategory.name;
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
        title: const Text('Edit Categories'),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _IconPickerField(
              controller: _nameController,
              pickedCategory: widget.pickedCategory,
            ),
            MyDivider(indent: dividerIndent),
            _ParentCategorySelector(pickedCategory: widget.pickedCategory),
            const SizedBox(height: 12),
            _DescriptionField(controller: _descriptionController),
            const SizedBox(height: 20),
            const _ActionButtons(),
          ],
        ),
      ),
    );
  }
}

// ---------------- Icon Picker ----------------
class _IconPickerField extends StatelessWidget {
  final TextEditingController controller;
  final PickedIconModel pickedCategory;

  const _IconPickerField({
    required this.controller,
    required this.pickedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: controller,
      hintText: 'Name',
      prefixIcon: GestureDetector(
        onTap: () {
          // TODO: Pick icon
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(pickedCategory.icon, width: 40),
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
  final PickedIconModel pickedCategory;

  const _ParentCategorySelector({required this.pickedCategory});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, value, child) {
        switch (value.iconCategoriesData.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());

          case Status.ERROR:
            return const Center(child: Text('Error loading icons'));

          case Status.COMPLETED:
            final expenseIcons = value.iconCategoriesData.data?.categoriesIconListMap['expense'] ?? [];

            final parent = _findParentCategory(expenseIcons);

            return MyListTitle(
              callback: () => context.push(FinalRoutes.selectParentCategories),
              title: 'Pick parent category',
              titleTextStyle: Theme.of(context).textTheme.labelSmall!,
              subTitle: Text(
                parent?.name ?? 'None',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading: Image.asset(
                parent?.icon ?? 'assets/another_icon/wallet.png',
                width: 40,
              ),
              leftContentPadding: 16,
              horizontalTitleGap: 10,
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  PickedIconModel? _findParentCategory(List<CategoriesIconModel> icons) {
    for (final parent in icons) {
      for (final child in parent.children) {
        if (child.id == pickedCategory.id) {
          return PickedIconModel(id: parent.id, name: parent.name, icon: parent.icon);
        }
      }
    }
    return null;
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
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Handle delete
              },
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  const BorderSide(color: emergencyColor),
                ),
              ),
              child: const Text(
                'DELETE',
                style: TextStyle(color: emergencyColor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle save
              },
              child: const Text('SAVE'),
            ),
          ),
        ),
      ],
    );
  }
}
