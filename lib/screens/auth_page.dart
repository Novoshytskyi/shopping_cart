import 'package:flutter/material.dart';
import '../classes/user_auth.dart';
import '../constants.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../widgets/reusable_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKeyAuthForm = GlobalKey<ScaffoldState>();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  bool _hidePass = true;

  UserAuth newUserAuth = UserAuth();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyAuthForm,
      appBar: AppBar(
        title: const Text(
          appBarAuthPageText,
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        //?---------------------------------------------
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'item1':
                  {
                    Navigator.pushNamed(context, '/page4');
                  }
                case 'item2':
                  {
                    Navigator.pushNamed(context, '/page4');
                  }
                case 'item3':
                  {
                    Navigator.pushNamed(context, '/page3');
                  }
                case 'item4':
                  {
                    Navigator.pushNamed(context, '/page5');
                  }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'item1',
                child: Row(
                  children: [
                    Text(popupMenuItemText1),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'item2',
                child: Row(
                  children: [
                    Text(popupMenuItemText2),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: null,
                child: Divider(
                  color: richColor,
                  thickness: 2.0,
                  // height: 1.0,
                ),
              ),
              const PopupMenuItem(
                value: 'item3',
                child: Row(
                  children: [
                    Text(popupMenuItemText3),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'item4',
                child: Row(
                  children: [
                    Text(popupMenuItemText4),
                  ],
                ),
              ),
            ],
          ),
        ],
        //?--------------------------------------------------------------
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //!---
                  // child: Center(
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //         TextFormField(
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //           focusNode: _emailFocus,
                  //           onFieldSubmitted: (_) {
                  //             _fieldFocusChange(
                  //                 context, _emailFocus, _passFocus);
                  //           },
                  //           controller: _emailController,
                  //           decoration: InputDecoration(
                  //             labelText: emailFormFieldLabelText,
                  //             hintText: emailFormFieldHintText,
                  //             prefixIcon: const Icon(
                  //               Icons.mail_outline,
                  //             ),
                  //             suffixIcon: GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   _emailController.clear();
                  //                 });
                  //               },
                  //               child: _emailController.text.isNotEmpty
                  //                   ? const Icon(Icons.close_outlined)
                  //                   : const SizedBox(),
                  //             ),
                  //           ),
                  //           keyboardType: TextInputType.emailAddress,
                  //           validator: _vaidateEmail,
                  //           onChanged: (value) {
                  //             setState(() {});
                  //           },
                  //           onSaved: (value) => newUserAuth.email = value,
                  //         ),
                  //         const SizedBox(
                  //           height: 25,
                  //         ),
                  //         TextFormField(
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //           focusNode: _passFocus,
                  //           controller: _passController,
                  //           obscureText: _hidePass,
                  //           decoration: InputDecoration(
                  //             labelText: passFormFieldLabelText,
                  //             hintText: passFormFieldHintTex,
                  //             prefixIcon: const Icon(
                  //               Icons.gpp_good_outlined,
                  //             ),
                  //             suffixIcon: IconButton(
                  //               icon: Icon(_hidePass
                  //                   ? Icons.visibility_off_outlined
                  //                   : Icons.visibility_outlined),
                  //               onPressed: () {
                  //                 setState(() {
                  //                   _hidePass = !_hidePass;
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  //           validator: _validatePassword,
                  //           onSaved: (value) =>
                  //               newUserAuth.password = value, //!!!
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //!---
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _emailFocus,
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(context, _emailFocus, _passFocus);
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: emailFormFieldLabelText,
                          hintText: emailFormFieldHintText,
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _emailController.clear();
                              });
                            },
                            child: _emailController.text.isNotEmpty
                                ? const Icon(Icons.close_outlined)
                                : const SizedBox(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _vaidateEmail,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onSaved: (value) => newUserAuth.email = value,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _passFocus,
                        controller: _passController,
                        obscureText: _hidePass,
                        decoration: InputDecoration(
                          labelText: passFormFieldLabelText,
                          hintText: passFormFieldHintTex,
                          prefixIcon: const Icon(
                            Icons.gpp_good_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_hidePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () {
                              setState(() {
                                _hidePass = !_hidePass;
                              });
                            },
                          ),
                        ),
                        validator: _validatePassword,
                        onSaved: (value) => newUserAuth.password = value, //!!!
                      ),
                    ],
                  ),
                  //!---
                ),
              ),
              ReusableButton(
                text: authButtonText,
                onPressed: () {
                  setState(() {
                    _submitForm();
                  });
                },
              ),
              ReusableButton(
                text: registerButtonText,
                onPressed: () {
                  setState(() {});
                  _formKey.currentState!.reset();
                  _emailController.text = '';
                  _passController.text = '';
                  _emailFocus.unfocus();
                  _passFocus.unfocus();

                  Navigator.pushNamed(context, '/page2');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _emailController.text = '';
      _passController.text = '';

      Navigator.pushNamed(context, '/page3');
    } else {
      showCustomSnackBar(context, submitFormMessage1);
    }
  }

  String? _vaidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return vaidateEmailText1;
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return vaidateEmailText2;
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length < 6 || _passController.text.length > 12) {
      return validatePasswordText1;
    } else {
      return null;
    }
  }
}
