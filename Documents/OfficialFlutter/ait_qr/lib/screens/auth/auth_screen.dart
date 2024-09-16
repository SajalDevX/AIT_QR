import 'package:ait_qr/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String? selectedBranch;
  String? email;
  String? password;

  final List<UserModel> branches = [
    UserModel(email: 'it@gmail.com', password: 'ankit988934A@', branch: 'IT'),
    UserModel(
        email: 'andtc@gmail.com', password: 'ankit988934A@', branch: 'E&TC'),
    UserModel(email: 'cse@gmail.com', password: 'ankit988934A@', branch: 'CSE'),
    UserModel(
        email: 'mech@gmail.com', password: 'ankit988934A@', branch: 'Mech'),
    // और शाखाएँ यहाँ जोड़ें
  ];

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserModel user = branches
          .firstWhere((u) => u.email == email && u.password == password);
      var result = await _authService.signIn(user);
      if (result != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(branch: user.branch)),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select Branch'),
                    items: branches.map((UserModel user) {
                      return DropdownMenuItem<String>(
                        value: user.branch,
                        child: Text(user.branch),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBranch = value;
                        var selectedUser =
                            branches.firstWhere((u) => u.branch == value);
                        email = selectedUser.email;
                        password = selectedUser.password;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a branch' : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: email,
                    decoration: InputDecoration(labelText: 'Email'),
                    readOnly: true,
                  ),
                  TextFormField(
                    initialValue: password,
                    decoration: InputDecoration(labelText: 'Password'),
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Sign In'),
                  )
                ],
              )),
        ));
  }
}
