import 'package:flutter/material.dart';
import 'package:shopping_cart/model/user.dart';
import '../db/database.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../user_secure_storage.dart';
// import '../widgets/popup_menu_button.dart';
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
  bool userIsActive = false;

  String? name;

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

  @override
  void initState() {
    super.initState();
    setState(() {});
    initFromSecureStorage();
    // Проверка и переход на экран 3
  }

  Future initFromSecureStorage() async {
    var currentUser = await UserSecureStorage.getCurrentUserInfo();

    final email = currentUser == null ? '' : currentUser.email;
    final pass = currentUser == null ? '' : currentUser.password;

    name = currentUser == null ? '' : currentUser.name;

    userIsActive = currentUser == null ? false : true;

    // goToProductsPage(userIsActive); //!!! ???

    setState(() {
      _emailController.text = email;
      _passController.text = pass;
    });
  }

  // void goToProductsPage(bool userIsActive) {
  //   //?
  //   if (userIsActive) {
  //     Navigator.pushNamed(context, '/page3');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyAuthForm,
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'ДОБРО ПОЖАЛОВАТЬ',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   PopupMenuButtonNew(
        //     onPressedLogOut: () {
        //       clearAuthFields();
        //       userIsActive = false;
        //       setState(() {
        //         name = '';
        //       });
        //     },
        //     userName: name,
        //   ),
        // ],
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
                          labelText: 'Введите e-mail',
                          hintText: 'e-mail',
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
                          labelText: 'Введите пароль',
                          hintText: 'Пароль',
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
                      ),
                    ],
                  ),
                ),
              ),
              ReusableButton(
                text: 'ВОЙТИ',
                onPressed: () {
                  setState(() {
                    _submitForm();
                  });
                },
              ),
              ReusableButton(
                text: 'РЕГИСТРАЦИЯ',
                onPressed: () {
                  if (userIsActive) {
                    showCustomSnackBar(context, 'Вы уже зарегестрированы');
                  } else {
                    setState(() {});
                    _formKey.currentState!.reset();
                    clearAuthFields();
                    _emailFocus.unfocus();
                    _passFocus.unfocus();

                    Navigator.pushNamed(context, '/page2');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearAuthFields() {
    _emailController.text = '';
    _passController.text = '';
  }

  void _submitForm() {
    if (userIsActive) {
      _emailController.text = '';
      _passController.text = '';
      Navigator.pushNamed(context, '/page3');
    } else if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugColorPrint('email: ${_emailController.text}');
      debugColorPrint('pass: ${_passController.text}');

      // Найденный по email пользователь становитвя активным (в SecureStorage)
      Future saveFoundUserToSecureStorage() async {
        User newUser = await DBProvider.db
            .getUserByEmail(_emailController.text.toString());
        await UserSecureStorage.setCurrentUserInfo(newUser);
      }

      // Выполняется при авторизации (email, password)
      void doIfPassIsAuth() {
        showCustomSnackBar(context, 'Вход выполнен');

        saveFoundUserToSecureStorage();

        _emailController.text = '';
        _passController.text = '';

        playSound();

        Navigator.pushNamed(context, '/page3');
      }

      void doIfPassNotAuth() {
        showCustomSnackBar(context, 'Пароль не подходит\n');
      }

      Future<void> passAuth() async {
        var passFromDb = await DBProvider.db
            .getPassByEmail(_emailController.text.toString());

        debugColorPrint('passFromDb: $passFromDb');

        if (passFromDb == _passController.text.toString()) {
          doIfPassIsAuth();
        } else {
          doIfPassNotAuth();
        }
      }

      passAuth();
    } else {
      showCustomSnackBar(
          context, 'Заполните поля корректно или зарегистрируйтесь');
    }
  }

  String? _vaidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите свой e-mail';
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return 'Введен не e-mail';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length < 6 || _passController.text.length > 12) {
      return 'Длина пароля 6..12 символов';
    } else {
      return null;
    }
  }
}
