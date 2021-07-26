import 'package:flutter/material.dart';
import 'package:prueba_ant_pack/repositories/repostitories.dart';
import 'package:prueba_ant_pack/models/models.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserRepository? _userRepository;
  bool? viewDetails;
  UserModel? selectedUser;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    viewDetails = false;
    selectedUser = null;
  }

  // Set style for every label
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  // Set style for every title
  Widget _buildTitle(String label) {
    return Text(label, style: Theme.of(context).textTheme.headline5);
  }

  // Iterate trough an users list and create the basic card display
  Widget _buildUserCard({required List<UserModel> users}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: Theme.of(context).primaryColor,
                  offset: Offset(1.0, 1.75),
                  spreadRadius: 0.5)
            ],
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTitle('Name:'),
                        SizedBox(height: 5),
                        _buildTitle('Email:'),
                        SizedBox(height: 5),
                        _buildTitle('City:'),
                        SizedBox(height: 5),
                        _buildTitle('Company:'),
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildLabel(users[index].name!),
                        SizedBox(height: 5),
                        _buildLabel(users[index].email!),
                        SizedBox(height: 5),
                        _buildLabel(users[index].address!.city!),
                        SizedBox(height: 5),
                        _buildLabel(users[index].company!.name!),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).buttonColor),
                      child: TextButton(
                        child: Text(
                          'View Details',
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedUser = users[index];
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildUserDetailsDialog();
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }, childCount: users.length),
    );
  }

  // Shows all the user cards
  Widget _buildUserCardsPage() {
    return FutureBuilder(
      future: _userRepository!.getUsers,
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> _users) {
        if (_users.hasData) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              slivers: <Widget>[_buildUserCard(users: _users.data!)],
            ),
          );
        } else if (_users.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Text('Ocurrió un error al cargar los datos de los usuarios'),
          );
        }
      },
    );
  }

  // Builds the rows of the user detail cards
  Widget _buildUserDetailRow({IconData? icon, String? title, String? label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 120,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    icon!,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(width: 5),
                  _buildTitle(title!),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_buildLabel(label!)],
          ),
        )
      ],
    );
  }

  // Builds the pop up of user detail info
  Widget _buildUserDetailsDialog() {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Theme.of(context).backgroundColor,
            child: Container(
                padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    _buildUserDetailRow(
                        icon: Icons.person,
                        label: selectedUser!.name,
                        title: 'Name:'),
                    SizedBox(height: 7),
                    _buildUserDetailRow(
                        icon: Icons.email,
                        label: selectedUser!.email,
                        title: 'Email:'),
                    SizedBox(height: 7),
                    _buildUserDetailRow(
                        icon: Icons.phone,
                        label: selectedUser!.phone,
                        title: 'Phone:'),
                    SizedBox(height: 7),
                    _buildUserDetailRow(
                        icon: Icons.web,
                        label: selectedUser!.website,
                        title: 'Website:'),
                    SizedBox(height: 7),
                    _buildUserDetailRow(
                        icon: Icons.business,
                        label: selectedUser!.company!.name,
                        title: 'Company:'),
                    SizedBox(height: 30),
                    Container(
                      height: 25,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).buttonColor),
                        onPressed: () {
                          // setState(() {
                          //   viewDetails = false;
                          //   selectedUser = null;
                          // });
                          Navigator.of(context).pop();
                        },
                        child: Text('Back'),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserCardsPage();
  }
}
