import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:flutter_boilerplate/services/user_service.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User> _users;
  @override
  void initState() {
    super.initState();
    Provider.of<UserService>(context, listen: false).users.then((users) {
      setState(() {
        _users = users;
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> _setUser(int index, Role role) async {
    var editedUser = User(
        id: _users[index].id,
        fullName: _users[index].fullName,
        birthDate: _users[index].birthDate,
        email: _users[index].email,
        gender: _users[index].gender,
        phoneNumber: _users[index].phoneNumber,
        role: role);
    editedUser = await Provider.of<UserService>(context, listen: false)
        .setOrAddUser(editedUser);
    setState(() {
      _users[index] = editedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _users == null || _users.length == 0
        ? Container(child: Center(child: CircularProgressIndicator()))
        : ListView.builder(
            itemCount: _users?.length,
            itemBuilder: (BuildContext ctxt, int index) {
              var user = _users?.elementAt(index);
              return UserListItem(
                user: user,
                setUser: (Role role) {
                  return _setUser(index, role);
                },
              );
            });
  }
}

class UserListItem extends StatefulWidget {
  final User user;
  final Function(Role role) setUser;

  UserListItem({Key key, @required this.user, @required this.setUser})
      : super(key: key);

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  var _isLoading = false;

  Color _getIconColorByRole(Role role) {
    switch (role) {
      case Role.Admin:
        return Colors.black;
      case Role.Coordinator:
        return Colors.orangeAccent;
      case Role.Regular:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;

    return ExpansionTile(
      trailing: _isLoading
          ? CircularProgressIndicator()
          : Container(
              width: 1.0,
            ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 40.0,
            color: _getIconColorByRole(user?.role),
          ),
        ],
      ),
      title: Text(user?.fullName ?? ''),
      initiallyExpanded: false,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.star),
          dense: true,
          title: Text(
            'role:',
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: DropdownButton<String>(
            elevation: 8,
            icon: Container(),
            value: user?.getRoleString(),
            onChanged: (String newValue) async {
              setState(() {
                _isLoading = true;
              });
              await widget.setUser(User.getRoleEnum(newValue));
              setState(() {
                _isLoading = false;
              });
            },
            items: ['admin', 'coordinator', 'regular'].toList().map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 20.0)),
              );
            }).toList(),
          ),
        ),
        // Text(user?.role?.toString()?.split('.')?.elementAt(1) ?? '')
      ],
    );
  }
}
