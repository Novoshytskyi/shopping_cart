import 'package:flutter/material.dart';
import '../classes/user_auth.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../widgets/reusable_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKeyAuthForm = GlobalKey<ScaffoldState>();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _passConfirmFocus = FocusNode();

  bool _hidePass = true;

  UserAuth newUserAuth = UserAuth();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _passConfirmFocus.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyAuthForm,
      appBar: AppBar(
        title: const Text(
          appBarRegisterPageText,
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
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
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         TextFormField(
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //           focusNode: _nameFocus,
                  //           onFieldSubmitted: (_) {
                  //             _fieldFocusChange(
                  //                 context, _nameFocus, _emailFocus);
                  //           },
                  //           controller: _nameController,
                  //           decoration: InputDecoration(
                  //             labelText: nameFormFieldLabelText,
                  //             hintText: nameFormFieldHintText,
                  //             prefixIcon: const Icon(
                  //               Icons.person_outlined,
                  //             ),
                  //             suffixIcon: GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   _nameController.clear();
                  //                 });
                  //               },
                  //               child: _nameController.text.isNotEmpty
                  //                   ? const Icon(Icons.close_outlined)
                  //                   : const SizedBox(),
                  //             ),
                  //           ),
                  //           keyboardType: TextInputType.emailAddress,
                  //           validator: _validateName,
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
                  //           onFieldSubmitted: (_) {
                  //             _fieldFocusChange(
                  //                 context, _passFocus, _passConfirmFocus);
                  //           },
                  //           controller: _passController,
                  //           obscureText: _hidePass,
                  //           decoration: InputDecoration(
                  //             // err
                  //             labelText: passFormFieldLabelText,
                  //             hintText: passFormFieldHintTex,
                  //             prefixIcon: const Icon(
                  //               Icons.gpp_good_outlined,
                  //             ),
                  //             suffixIcon: IconButton(
                  //               // color: richColor,
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
                  //         const SizedBox(
                  //           height: 25,
                  //         ),
                  //         TextFormField(
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //           focusNode: _passConfirmFocus,
                  //           controller: _confirmPassController,
                  //           obscureText: _hidePass,
                  //           decoration: const InputDecoration(
                  //             labelText: confirmPassFormFieldLabelText,
                  //             hintText: confirmPassFormFieldHintTex,
                  //             filled: true,
                  //             prefixIcon: Icon(Icons.gpp_maybe_outlined),
                  //           ),
                  //           // validator: _validatePassword,
                  //           validator: _validatePasswordConfirm,
                  //         ),
                  //         const SizedBox(
                  //           height: 10.0,
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
                        focusNode: _nameFocus,
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(context, _nameFocus, _emailFocus);
                        },
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: nameFormFieldLabelText,
                          hintText: nameFormFieldHintText,
                          prefixIcon: const Icon(
                            Icons.person_outlined,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _nameController.clear();
                              });
                            },
                            child: _nameController.text.isNotEmpty
                                ? const Icon(Icons.close_outlined)
                                : const SizedBox(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateName,
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
                        onFieldSubmitted: (_) {
                          _fieldFocusChange(
                              context, _passFocus, _passConfirmFocus);
                        },
                        controller: _passController,
                        obscureText: _hidePass,
                        decoration: InputDecoration(
                          // err
                          labelText: passFormFieldLabelText,
                          hintText: passFormFieldHintTex,
                          prefixIcon: const Icon(
                            Icons.gpp_good_outlined,
                          ),
                          suffixIcon: IconButton(
                            // color: richColor,
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
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodySmall,
                        focusNode: _passConfirmFocus,
                        controller: _confirmPassController,
                        obscureText: _hidePass,
                        decoration: const InputDecoration(
                          labelText: confirmPassFormFieldLabelText,
                          hintText: confirmPassFormFieldHintTex,
                          filled: true,
                          prefixIcon: Icon(Icons.gpp_maybe_outlined),
                        ),
                        // validator: _validatePassword,
                        validator: _validatePasswordConfirm,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  //!---
                ),
              ),
              ReusableButton(
                text: registerButtonText,
                onPressed: () {
                  // playSound();
                  setState(() {
                    _submitForm();
                  });
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

      DBProvider.db.insertUser(
        User(
          id: null,
          name: _nameController.text,
          email: _emailController.text,
          password: _passController.text,
        ),
      );

      _nameController.text = '';
      _emailController.text = '';
      _passController.text = '';
      _confirmPassController.text = '';

      playSound();
      showCustomSnackBar(context, registerOkMessage);

      Navigator.pushNamed(context, '/page3');
    } else {
      showCustomSnackBar(context, submitFormMessage2);
    }
  }

  String? _validateName(String? value) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _nameExp = RegExp(r'^[A-Za-zА-Яа-я. ]+$');
    if (value == null || value.isEmpty) {
      return validateNameText1;
    } else if (!_nameExp.hasMatch(value)) {
      return validateNameText2;
    } else {
      return null;
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

  String? _validatePasswordConfirm(String? value) {
    if (_confirmPassController.text != _passController.text) {
      return validatePasswordText2;
    } else {
      return null;
    }
  }
}
