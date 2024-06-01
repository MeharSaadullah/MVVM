import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/modal/home_view_modal.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/routes/utils.dart';
import 'package:mvvm/view_modal/user_view_modal.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModal homeViewViewModal = HomeViewViewModal();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModal.movielist;
    super.initState();
  }

  Widget build(BuildContext context) {
    final userPrefrences = Provider.of<UserViewModal>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: [
            InkWell(
                onTap: () {
                  userPrefrences.remove().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: Center(child: Text('logout'))),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: ChangeNotifierProvider<HomeViewViewModal>(
          create: (BuildContext context) => homeViewViewModal,
          child: Consumer<HomeViewViewModal>(
            builder: (context, value, _) {
              switch (value.movielist.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Text(value.movielist.message.toString());

                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.movielist.data!.movies!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          leading: Image.network(
                              value.movielist.data!.movies![index].posterurl
                                  .toString(),
                              errorBuilder: (context, error, stack) {
                            return Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          }, height: 40, width: 40, fit: BoxFit.cover),
                          title: Text(value.movielist.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .movielist.data!.movies![index].year
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value
                                      .movielist.data!.movies![index].ratings!)
                                  .toStringAsFixed(1)),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        ));
                      });
                default:
              }
              return Container();
            },
          ),
        ));
  }
}
