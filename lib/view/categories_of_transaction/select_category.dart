import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transaction_categories_icon_model.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/widgets/create_category_section.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/categories_icon_parent.dart';
import 'package:fe_financial_manager/view/common_widget/tab_bar_elements.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key, this.pickedCategory, required this.onItemTap});
  final PickedIconModel ? pickedCategory;
  final Future<void> Function(PickedIconModel) onItemTap;
  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTab = 0;
  AppViewModel viewModel = AppViewModel();
  // if the expansion tile is expanded
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dividerIndent = screenHeight * 0.094;
    String currentRoute = GoRouterState.of(context).uri.toString();
    bool isFromAccountScreen = currentRoute.contains('account');
    return Scaffold(
      key: const ValueKey('selectCategory'),
      appBar: AppBar(
        title: Text(isFromAccountScreen ? 'Edit Category' : 'Select Category'),
        leading: const CustomBackNavbar(),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tab bar
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  TabBarElements(
                    tabController: _tabController,
                    selectedTab: _selectedTab,
                    index: 0,
                    title: 'Expense',
                  ),
                  TabBarElements(
                    tabController: _tabController,
                    selectedTab: _selectedTab,
                    index: 1,
                    title: 'Income',
                  ),
                ],
              ),
            ),
          ),
          // Tab bar view
          Expanded(
            child: Consumer<AppViewModel>(
              builder: (context, value, child) {
                switch(value.iconCategoriesData.status){
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:
                    final expenseIconsList = value.iconCategoriesData.data?.categoriesIconListMap['expense'];
                    final incomeIconsList = value.iconCategoriesData.data?.categoriesIconListMap['income'];
                    if (expenseIconsList == null || expenseIconsList.isEmpty) {
                      return const Center(child: Text("No icons available"));
                    }
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const CreateCategorySection(),
                              const SizedBox(height: 10),
                              ...expenseIconsList.map<Widget>((e) {
                                CategoriesIconModel categoriesIconParent = e as CategoriesIconModel; // Proper casting
                                return CategoriesIconParent(
                                  parentIcon: categoriesIconParent,
                                  onTap: widget.onItemTap,
                                  pickedCategoryId: widget.pickedCategory?.id,
                                );
                              }).toList()
                            ],
                          ),
                        ),
                        // Income tab
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const CreateCategorySection(),
                              const SizedBox(height: 10),
                              ...incomeIconsList.map<Widget>((e) {
                                CategoriesIconModel categoriesIconParent = e as CategoriesIconModel; // Proper casting
                                return CategoriesIconParent(
                                  parentIcon: categoriesIconParent,
                                  onTap: widget.onItemTap,
                                  pickedCategoryId: widget.pickedCategory?.id,
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      ]
                    );
                  case Status.ERROR:
                    throw UnimplementedError();
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
