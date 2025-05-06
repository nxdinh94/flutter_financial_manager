import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/utils/routes/my_bottom_navigation_bar.dart';
import 'package:fe_financial_manager/view/account_tab/account_setting.dart';
import 'package:fe_financial_manager/view/account_tab/events_of_transactions/create_events.dart';
import 'package:fe_financial_manager/view/account_tab/events_of_transactions/events.dart';
import 'package:fe_financial_manager/view/adding_workspace/add_note.dart';
import 'package:fe_financial_manager/view/adding_workspace/ai_result.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/edit_categories.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/pick_icon_path_category.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/select_category.dart';
import 'package:fe_financial_manager/view/adding_workspace/select_wallets.dart';
import 'package:fe_financial_manager/view/auth/change_password.dart';
import 'package:fe_financial_manager/view/auth/forgot_password.dart';
import 'package:fe_financial_manager/view/auth/home_auth.dart';
import 'package:fe_financial_manager/view/auth/signup.dart';
import 'package:fe_financial_manager/view/budgets/budget_details.dart';
import 'package:fe_financial_manager/view/budgets/create_update_budget.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/create_category.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/select_parent_categories.dart';
import 'package:fe_financial_manager/view/home_tab/group_transaction_detail.dart';
import 'package:fe_financial_manager/view/home_tab/summary_detail.dart';
import 'package:fe_financial_manager/view/tab_screen/all_wallets.dart';
import 'package:fe_financial_manager/view/tab_screen/account.dart';
import 'package:fe_financial_manager/view/tab_screen/adding_workspace.dart';
import 'package:fe_financial_manager/view/tab_screen/budgets.dart';
import 'package:fe_financial_manager/view/tab_screen/home.dart';
import 'package:fe_financial_manager/view/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../view/transaction_history/choose_range_time.dart';
import '../../view/transaction_history/transactions_history.dart';
import '../../view/wallets_tab/add_wallets.dart';
import '../../view/wallets_tab/external_bank.dart';
import '../../view/wallets_tab/pick_wallet_types.dart';
import 'routes_name.dart';

class CustomNavigationHelper {
  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> walletTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> addingWorkspaceTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> budgetsTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> accountTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> authTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  CustomNavigationHelper._internal();
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal(); //instance of CustomNavigatorHelper
  static CustomNavigationHelper get instance => _instance;
  factory CustomNavigationHelper(String initialRoute) {
    return _instance._initialize(initialRoute);
  }

  CustomNavigationHelper _initialize(String initialRoute) {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutesName.homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const Home(),
                    state: state,
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: RoutesName.transactionHistoryDetailPath,
                    pageBuilder: (context, GoRouterState state) {
                      String nameOfSelectedRangeTime = state.extra as String;
                      return getPage(
                        child: TransactionsHistory(nameOfSelectedRangeTime: nameOfSelectedRangeTime,),
                        state: state,
                      );
                    },
                  ),
                  GoRoute(
                    path: RoutesName.summaryDetailPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const SummaryDetail(),
                        state: state,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: RoutesName.groupTransactionDetailPath,
                        pageBuilder: (context, GoRouterState state) {
                          Map<String, dynamic> data = state.extra as Map<String, dynamic>;

                          String parentName = data['parentName'];
                          String transactionType = data['transactionType'];
                          return getPage(
                            child: GroupTransactionDetail(
                              parentName: parentName,
                              transactionType: transactionType,
                            ),
                            state: state,
                          );
                        },
                      )
                    ]
                  ),
                ]
              ),
              GoRoute(
                  path: RoutesName.addWalletsPath,
                  pageBuilder: (context, GoRouterState state) {
                    if (state.extra == null) {
                      return getPage(
                        child: const AddWallets(),
                        state: state,
                      );
                    } else {
                      SingleWalletModel walletToUpdate =
                          state.extra as SingleWalletModel;
                      return getPage(
                        child: AddWallets(
                          walletToUpdate: walletToUpdate,
                        ),
                        state: state,
                      );
                    }
                  },
                  routes: [
                    GoRoute(
                      path: RoutesName.pickWalletTypePath,
                      pageBuilder: (context, GoRouterState state) {
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;
                        PickedIconModel pickedWalletType =
                            data['pickedWalletType'];
                        Future<void> Function(PickedIconModel) onTap =
                            data['onTap'];
                        return getPage(
                          child: PickWalletTypes(
                            pickedWalletType: pickedWalletType,
                            onItemTap: onTap,
                          ),
                          state: state,
                        );
                      },
                    ),
                    GoRoute(
                      path: RoutesName.pickExternalBankPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(
                          child: const ExternalBank(),
                          state: state,
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
              navigatorKey: walletTabNavigatorKey,
              routes: [
                GoRoute(
                  path: RoutesName.walletPath,
                  pageBuilder: (context, GoRouterState state) {
                    return getPage(child: const AllWallets(), state: state);
                  },
                  routes:  [
                    GoRoute(
                      path: RoutesName.chooseRangeTimeToShowTransactionPath,
                      pageBuilder: (context, GoRouterState state) {
                        String nameOfSelectedRangeTime = (state.extra ?? '') as String ;
                        return getPage(
                          child: ChooseRangeTime(nameOfSelectedRangeTime: nameOfSelectedRangeTime,),
                          state: state
                        );
                      }
                    ),
                    GoRoute(
                      path: RoutesName.transactionHistoryDetailPath,
                      pageBuilder: (context, GoRouterState state) {
                        String walletId = (state.extra ?? '') as String;
                        return getPage(
                          child: TransactionsHistory(walletId: walletId),
                          state: state,
                        );
                      },
                    ),
                  ]
                )
              ]),
          StatefulShellBranch(
              navigatorKey: addingWorkspaceTabNavigatorKey,
              routes: [
                GoRoute(
                  path: RoutesName.addingWorkSpacePath,
                  pageBuilder: (context, GoRouterState state) {
                    if(state.extra == null){
                      return getPage(child: const AddingWorkspace(), state: state);
                    }
                    TransactionHistoryModel data = state.extra as TransactionHistoryModel;
                    return getPage(
                      child: AddingWorkspace(transactionToUpdate: data),
                      state: state
                    );
                  },
                  routes: [
                    GoRoute(
                      path: RoutesName.selectWalletPath,
                      pageBuilder: (context, GoRouterState state) {
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;
                        PickedIconModel pickedWallet = data['pickedWallet'];
                        Future<void> Function(PickedIconModel) onTap =
                            data['onTap'];
                        return getPage(
                            child: SelectWallets(
                              pickedWallet: pickedWallet,
                              onItemTap: onTap,
                            ),
                            state: state);
                      },
                    ),
                    GoRoute(
                      path: RoutesName.addNotePath,
                      pageBuilder: (context, GoRouterState state) {
                        dynamic data = state.extra as String;
                        return getPage(
                            child: AddNote(
                              note: data,
                            ),
                            state: state);
                      },
                    ),
                    GoRoute(
                      path: RoutesName.pickCategoryPath,
                      pageBuilder: (context, GoRouterState state) {
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;
                        PickedIconModel pickedCategory =
                            data['pickedCategory'];
                        Future<void> Function(PickedIconModel) onTap =
                            data['onTap'];
                        return getPage(
                            child: SelectCategory(
                              pickedCategory: pickedCategory,
                              onItemTap: onTap,
                            ),
                            state: state);
                      },
                    ),
                    GoRoute(
                      path: RoutesName.aiResultPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(
                          child: const AiResult(),
                          state: state,
                        );
                      },
                    ),
                  ]),
              ]),
          StatefulShellBranch(navigatorKey: budgetsTabNavigatorKey, routes: [
            GoRoute(
                path: RoutesName.budgetsPath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(child: const Budgets(), state: state);
                },
                routes: [
                  GoRoute(
                    path: RoutesName.createUpdateBudgetPath,
                    pageBuilder: (context, GoRouterState state) {
                      if(state.extra == null){
                        return getPage(
                            child: const CreateUpdateBudget(),
                            state: state
                        );
                      }else {
                        Map<String, dynamic> data = state.extra as Map<String, dynamic> ;
                        return getPage(
                            child: CreateUpdateBudget(budgets: data,),
                            state: state
                        );
                      }
                    },
                  ),
                  GoRoute(
                    path: RoutesName.budgetDetailPath,
                    pageBuilder: (context, GoRouterState state) {
                      Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                      return getPage(
                        child: BudgetDetails(data: data),
                        state: state
                      );
                    },
                  ),
                ])
            ]),
          StatefulShellBranch(
            navigatorKey: accountTabNavigatorKey,
            routes: [
              GoRoute(
                  path: RoutesName.accountPath,
                  pageBuilder: (context, GoRouterState state) {
                    return getPage(child: const Account(), state: state);
                  },
                  routes: [
                    GoRoute(
                        path: RoutesName.accountSettingsPath,
                        pageBuilder: (context, GoRouterState state) {
                          return getPage(child: AccountSetting(), state: state);
                        }),
                    GoRoute(
                      path: RoutesName.allCategoryPath,
                      pageBuilder: (context, GoRouterState state) {
                        Map<String, dynamic> data =
                            state.extra as Map<String, dynamic>;
                        Future<void> Function(PickedIconModel) onTap =
                            data['onTap'];
                        return getPage(
                          child: SelectCategory(
                            onItemTap: onTap,
                          ),
                          state: state
                        );
                      },
                    ),
                    GoRoute(
                      path: RoutesName.eventPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(child: const Events(), state: state);
                      },
                    ),
                    GoRoute(
                      path: RoutesName.createEventPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(child: const CreateEvents(), state: state);
                      },
                    ),
                    GoRoute(
                        path: RoutesName.editCategoryPath,
                        pageBuilder: (context, GoRouterState state) {
                          Map<String, dynamic> data =
                              state.extra as Map<String, dynamic>;
                          PickedIconModel pickedCategory = data['pickedCategory'];
                          return getPage(
                              child: EditCategories(
                                pickedCategory: pickedCategory,
                              ),
                              state: state);
                        },
                        routes: [
                          GoRoute(
                            path: RoutesName.selectParentCategoriesPath,
                            pageBuilder: (context, GoRouterState state) {
                              Map<String, dynamic> data =
                                  state.extra as Map<String, dynamic>;
                              return getPage(
                                child: SelectParentCategories(
                                  onTap: data['onTap'],
                                  selectedTransactionTypeId: data['selectedTransactionTypeId'],
                                ),
                                state: state
                              );
                            },
                          ),
                          GoRoute(
                            path: RoutesName.pickIconPathForCategoryPath,
                            pageBuilder: (context, GoRouterState state) {

                              return getPage(
                                child: PickIconPathCategory(),
                                state: state
                              );
                            },
                          ),

                        ]),
                  ]
              ),
              GoRoute(
                path: RoutesName.addNewCategoryPath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(child: CreateCategory(), state: state);
                },
              ),
          ])
        ],
        pageBuilder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return getPage(
            child: MyBottomNavigationBar(
              child: navigationShell
            ),
            state: state,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: authTabNavigatorKey,
            routes: [
              GoRoute(
                  path: RoutesName.homeAuthPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: HomeAuth(),
                      state: state,
                    );
                  },
                  routes: [
                    GoRoute(
                        path: RoutesName.signUpPath,
                        pageBuilder: (context, state) {
                          return getPage(child: const Signup(), state: state);
                        }),
                    GoRoute(
                        path: RoutesName.signInPath,
                        pageBuilder: (context, state) {
                          return getPage(child: Signin(), state: state);
                        }),
                    GoRoute(
                        path: RoutesName.forgotPasswordPath,
                        pageBuilder: (context, state) {
                          return getPage(child: ForgotPassword(), state: state);
                        }),
                  ]),
              GoRoute(
                  path: RoutesName.changePasswordPath,
                  pageBuilder: (context, state) {
                    return getPage(child: ChangePassword(), state: state);
              }),
            ],
          )
        ],
        pageBuilder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return getPage(
            child: navigationShell, // Show it elsewhere
            state: state,
          );
        },
      )
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: initialRoute,
      routes: routes,
    );
    return this;
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      child: child,
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
