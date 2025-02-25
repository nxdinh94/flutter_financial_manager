// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/home_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: () {
                AuthManager.logout();
                context.pushReplacement(RoutesName.homeAuthPath);
              },
              child: Center(child: Text('Logout'))),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
          switch (value.moviesList.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.moviesList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(value.moviesList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value
                            .moviesList.data!.movies![index].year
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value
                                    .moviesList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            case null:
              // TODO: Handle this case.
          }
          return Container();
        }),
      ),
    );
  }
}