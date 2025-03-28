import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/utils/routes/my_bottom_navigation_bar.dart';
import 'package:fe_financial_manager/view/account_tab/account_setting.dart';
import 'package:fe_financial_manager/view/account_tab/events_of_transactions/create_events.dart';
import 'package:fe_financial_manager/view/account_tab/events_of_transactions/events.dart';
import 'package:fe_financial_manager/view/adding_workspace/add_note.dart';
import 'package:fe_financial_manager/view/adding_workspace/select_category.dart';
import 'package:fe_financial_manager/view/adding_workspace/select_wallets.dart';
import 'package:fe_financial_manager/view/auth/change_password.dart';
import 'package:fe_financial_manager/view/auth/forgot_password.dart';
import 'package:fe_financial_manager/view/auth/home_auth.dart';
import 'package:fe_financial_manager/view/auth/signup.dart';
import 'package:fe_financial_manager/view/budgets/budget_details.dart';
import 'package:fe_financial_manager/view/budgets/create_update_budget.dart';
import 'package:fe_financial_manager/view/categories_of_transaction/create_category.dart';
import 'package:fe_financial_manager/view/wallets/add_wallets.dart';
import 'package:fe_financial_manager/view/wallets/all_wallets.dart';
import 'package:fe_financial_manager/view/tab_screen/account.dart';
import 'package:fe_financial_manager/view/tab_screen/adding_workspace.dart';
import 'package:fe_financial_manager/view/tab_screen/budgets.dart';
import 'package:fe_financial_manager/view/tab_screen/home.dart';
import 'package:fe_financial_manager/view/auth/signin.dart';
import 'package:fe_financial_manager/view/tab_screen/transactions.dart';
import 'package:fe_financial_manager/view/wallets/external_bank.dart';
import 'package:fe_financial_manager/view/wallets/pick_wallet_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes_name.dart';

class CustomNavigationHelper {


  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> transactionsTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> addingWorkspaceTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> budgetsTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> accountTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> authTabNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser => router.routeInformationParser;


  CustomNavigationHelper._internal();
  static final CustomNavigationHelper _instance = CustomNavigationHelper._internal();//instance of CustomNavigatorHelper
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
                      path: RoutesName.allWalletsPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(
                          child: const AllWallets(),
                          state: state,
                        );
                      },
                    ),
                  ]
              ),
              GoRoute(
                path: RoutesName.addWalletsPath,
                pageBuilder: (context, GoRouterState state) {
                  if(state.extra == null){
                    return getPage(
                      child: AddWallets(),
                      state: state,
                    );
                  }else {
                    WalletModel walletToUpdate = state.extra as WalletModel;
                    return getPage(
                      child: AddWallets(walletToUpdate: walletToUpdate,),
                      state: state,
                    );
                  }

                },
                routes: [
                  GoRoute(
                      path: RoutesName.pickWalletTypePath,
                      pageBuilder: (context, GoRouterState state) {
                        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                        PickedIconModel pickedWalletType = data['pickedWalletType'];
                        void Function (PickedIconModel) onTap = data['onTap'];
                        return getPage(
                          child: PickWalletTypes(pickedWalletType: pickedWalletType, onItemTap: onTap,),
                          state: state,
                        );
                      },
                  ),
                  GoRoute(
                      path: RoutesName.pickExternalBankPath,
                      pageBuilder: (context, GoRouterState state) {
                        return getPage(
                          child: ExternalBank(),
                          state: state,
                        );
                      },
                  ),
                ]
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: transactionsTabNavigatorKey,
            routes: [
              GoRoute(
                path: RoutesName.transactionsPath,
                pageBuilder: (context, GoRouterState state){
                  return getPage(
                    child: const Transactions(),
                    state: state
                  );
                },
                routes: [

                ]
              )
            ]
          ),
          StatefulShellBranch(
              navigatorKey: addingWorkspaceTabNavigatorKey,
              routes: [
                GoRoute(
                    path: RoutesName.addingWorkSpacePath,
                    pageBuilder: (context, GoRouterState state){
                      return getPage(
                          child: AddingWorkspace(),
                          state: state
                      );
                    },
                    routes: [
                      GoRoute(
                        path: RoutesName.selectWalletPath,
                        pageBuilder: (context, GoRouterState state){
                          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                          PickedIconModel pickedWallet = data['pickedCategory'];
                          void Function(PickedIconModel) onTap = data['onTap'];
                          return getPage(
                              child: SelectWallets(pickedWallet: pickedWallet, onItemTap: onTap,),
                              state: state
                          );
                        },
                      ),
                      GoRoute(
                        path: RoutesName.addNotePath,
                        pageBuilder: (context, GoRouterState state){
                          dynamic  data = state.extra as String;
                          return getPage(
                              child: AddNote(note: data,),
                              state: state
                          );
                        },
                      ),
                      GoRoute(
                        path: RoutesName.pickCategoryPath,
                        pageBuilder: (context, GoRouterState state){
                          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                          PickedIconModel pickedCategory = data['pickedCategory'];
                          void Function(PickedIconModel) onTap = data['onTap'];
                          return getPage(
                              child: SelectCategory(pickedCategory: pickedCategory, onItemTap: onTap,),
                              state: state
                          );
                        },
                      ),
                    ]
                ),
              ]
          ),
          StatefulShellBranch(
              navigatorKey: budgetsTabNavigatorKey,
              routes: [
                GoRoute(
                    path: RoutesName.budgetsPath,
                    pageBuilder: (context, GoRouterState state){
                      return getPage(
                          child: Budgets(),
                          state: state
                      );
                    },
                    routes: [
                      GoRoute(
                          path: RoutesName.createUpdateBudgetPath,
                          pageBuilder: (context, GoRouterState state){
                            return getPage(
                                child: CreateUpdateBudget(),
                                state: state
                            );
                          },
                          routes: [

                          ]
                      ),
                      GoRoute(
                          path: RoutesName.budgetDetailPath,
                          pageBuilder: (context, GoRouterState state){
                            Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                            return getPage(
                                child: BudgetDetails(
                                  dataToPassSpendingLimitItemWidget: data
                                ),
                                state: state
                            );
                          },
                          routes: [

                          ]
                      ),

                    ]
                )
              ]
          ),
          StatefulShellBranch(
              navigatorKey: accountTabNavigatorKey,
              routes: [
                GoRoute(
                    path: RoutesName.accountPath,
                    pageBuilder: (context, GoRouterState state){
                      return getPage(
                          child: Account(),
                          state: state
                      );
                    },
                    routes: [
                      GoRoute(
                        path: RoutesName.accountSettingsPath,
                        pageBuilder: (context, GoRouterState state){
                          return getPage(
                            child: AccountSetting(),
                            state: state
                          );
                        }
                      ),
                      GoRoute(
                        path: RoutesName.allCategoryPath,
                        pageBuilder: (context, GoRouterState state){
                          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                          void Function(PickedIconModel) onTap = data['onTap'];
                          return getPage(
                              child: SelectCategory(onItemTap: onTap,),
                              state: state
                          );
                        },
                      ),

                      GoRoute(
                        path: RoutesName.eventPath,
                        pageBuilder: (context, GoRouterState state){
                          return getPage(
                              child: Events(),
                              state: state
                          );
                        },
                      ),
                      GoRoute(
                        path: RoutesName.createEventPath,
                        pageBuilder: (context, GoRouterState state){
                          return getPage(
                              child: CreateEvents(),
                              state: state
                          );
                        },
                      ),
                    ]
                ),
                GoRoute(
                  path: RoutesName.addNewCategoryPath,
                  pageBuilder: (context, GoRouterState state){
                    return getPage(
                        child: CreateCategory(),
                        state: state
                    );
                  },
                ),
              ]
          )
        ],
        pageBuilder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell
            ) {
          return getPage(
            child:  MyBottomNavigationBar(child: navigationShell), // Show it elsewhere
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
                      pageBuilder: (context, state){
                        return getPage(
                            child: const Signup(),
                            state: state
                        );
                      }
                  ),
                  GoRoute(
                      path: RoutesName.signInPath,
                      pageBuilder: (context, state){
                        return getPage(
                            child: Signin(),
                            state: state
                        );
                      }
                  ),
                  GoRoute(
                      path: RoutesName.forgotPasswordPath,
                      pageBuilder: (context, state){
                        return getPage(
                            child: ForgotPassword(),
                            state: state
                        );
                      }
                  ),
                ]
              ),
              GoRoute(
                path: RoutesName.changePasswordPath,
                pageBuilder: (context, state){
                  return getPage(
                    child: ChangePassword(),
                    state: state
                  );
                }
              )
            ],
          )
        ],
        pageBuilder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell
            ) {
          return getPage(
            child:  navigationShell, // Show it elsewhere
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
