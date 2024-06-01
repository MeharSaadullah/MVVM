import 'package:flutter/material.dart';
import 'package:mvvm/resources/componenets/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/routes/utils.dart';
//import 'package:mvvm/view/home_screen.dart';
import 'package:provider/provider.dart';
import '../view_modal/auth_view_modal.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ValueNotifier<bool> _obsecurepassword =
      ValueNotifier<bool>(true); // for visibility of password
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    emailfocusnode.dispose();
    passwordfocusnode.dispose();

    _obsecurepassword.dispose();
  }

  Widget build(BuildContext context) {
    final authViewModal = Provider.of<AuthViewModal>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Login'),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailcontroller,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailfocusnode,
              decoration: InputDecoration(
                  hintText: 'E-mail',
                  labelText: 'E_mail',
                  prefixIcon: Icon(Icons.email_outlined)),
              onFieldSubmitted: (value) {
                Utils.fieldfocuschange(
                    // use this for change the focus of container to next text foam field
                    context,
                    emailfocusnode,
                    passwordfocusnode);
              },
            ),
            ValueListenableBuilder(
                // use all  this for visibility or unvisibility of password
                valueListenable: _obsecurepassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordcontroller,
                    obscureText: _obsecurepassword.value,
                    obscuringCharacter: '*',
                    focusNode: passwordfocusnode,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurepassword.value = !_obsecurepassword.value;
                          },
                          child: Icon(_obsecurepassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)),
                    ),
                  );
                }),
            SizedBox(
              height: height * .1,
            ),
            RoundButton(
              title: 'login',
              loading: authViewModal.loading,
              onpress: () {
                if (_emailcontroller.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please Enter E_mail', context);
                } else if (_passwordcontroller.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      'Kindly Enter your password', context);
                } else if (_passwordcontroller.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Please enter 6 digit password', context);
                }
                //
                else if (_passwordcontroller.text.isEmpty ||
                    _emailcontroller.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      'Kindly Enter your  e-mail and password', context);
                }

                //
                else {
                  // Map data = {
                  //   'email': _emailcontroller.text.toString(),
                  //   'password': _passwordcontroller.text.toString(),
                  // };
                  Map data = {
                    'email': 'eve.holt@reqres.in',
                    'password': 'cityslicka',
                  };
                  authViewModal.authloginApi(data, context);

                  print('API Hit');
                }
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                child: Text('Dont have account? Sign Up')),

            // Center(
            //     child: InkWell(
            //         onTap: () {
            //           Utils.flushBarErrorMessage(
            //               'No internet connection', context);
            //           Utils.toastMessage(' No internet connection');
            //           //Navigator.pushNamed(context,RoutesName.home);
            //         },
            //         child: Text('saad')))
          ],
        ),
      ),
    );
  }
}
