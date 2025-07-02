import 'package:flutter/material.dart';

import 'model/product.dart';
import 'theme_settings.dart';

// String titleMaterialApp = 'Shopping';

// const appBarAuthPageText = 'ДОБРО ПОЖАЛОВАТЬ';
// const authButtonText = 'ВОЙТИ';
// const registerButtonText = 'РЕГИСТРАЦИЯ';
// const registerOkMessage = 'Регистрация успешна';
// const submitFormMessage1 = 'Заполните поля корректно или зарегистрируйтесь';
// const submitFormMessage2 = 'Заполните поля корректно';

// const vaidateEmailText1 = 'Введите свой e-mail';
// const vaidateEmailText2 = 'Введен не e-mail';

// const validatePasswordText1 = 'Длина пароля 6..12 символов';
// const validatePasswordText2 = 'Пароли должны совпадать';

// const validateNameText1 = 'Введите своё Имя';
// const validateNameText2 = 'Символы в имени не допустимы';

// const nameFormFieldLabelText = 'Введите Имя';
// const nameFormFieldHintText = 'Имя';

// const emailFormFieldLabelText = 'Введите e-mail';
// const emailFormFieldHintText = 'e-mail';

// const passFormFieldLabelText = 'Введите пароль';
// const passFormFieldHintTex = 'Пароль';

// const confirmPassFormFieldLabelText = 'Повторно введите пароль';
// const confirmPassFormFieldHintTex = 'Пароль';

// const appBarRegisterPageText = 'РЕГИСТРАЦИЯ';

// const appBarProductsPageText = 'ТОВАРЫ';
// const productsSnackBarText = 'Добавлен в корзину';
// const showShoppingCartButtonText = 'ПОКАЗАТЬ КОРЗИНУ';

// const appBarShoppingCartText = 'КОРЗИНА';
// const shoppingCartSnackBarText = 'Товар удален';
// const orderCompletedSnackBarText = 'Заказ принят';
// const makeOrderButtonText = 'СДЕЛАТЬ ЗАКАЗ';

// const popupMenuItemText1 = 'Корзина';
// const popupMenuItemText2 = 'Покупки';
// const popupMenuItemText3 = 'Товары';
// const popupMenuItemText4 = 'Пользователи';

// const usersInfoMessage = 'Данные Пользователей не найденны.';
// const productsPageMessage = 'Данные Продуктов не найденны.';

Icon shoppingCartIcon = const Icon(
  Icons.shopping_cart_outlined,
  size: 24.0,
  color: lightColor,
);

Icon deleteIcon = const Icon(
  Icons.delete_outline,
  size: 24.0,
  color: lightColor,
);

List<Product> productsInShoppingCart = [];

// List<Product> productsAll = [
//   Product(
//     id: '1',
//     name: 'Apple MacBook Air M4',
//     price: '1000',
//     image: 'images/air-m4-starlight.jpg',
//   ),
//   Product(
//     id: '2',
//     name: 'Apple MacBook Air M4',
//     price: '1000',
//     image: 'images/air-m4-silver.jpg',
//   ),
//   Product(
//     id: '3',
//     name: 'Apple MacBook Air M4',
//     price: '1000',
//     image: 'images/air-m4-sky-blue.jpg',
//   ),
//   Product(
//     id: '4',
//     name: 'Apple MacBook Air M4',
//     price: '1000',
//     image: 'images/air-m4-midnight.jpg',
//   ),
//   Product(
//     id: '5',
//     name: 'Apple MacBook Air M1',
//     price: '800',
//     image: 'images/air-m1-space-gray.jpg',
//   ),
//   Product(
//     id: '6',
//     name: 'Apple MacBook Air M1',
//     price: '800',
//     image: 'images/air-m1-gold.jpg',
//   ),
//   Product(
//     id: '7',
//     name: 'Apple MacBook Pro M4',
//     price: '1600',
//     image: 'images/pro-m4-silver.jpg',
//   ),
//   Product(
//     id: '8',
//     name: 'Apple MacBook Pro M4',
//     price: '1600',
//     image: 'images/pro-m4-space-black.jpg',
//   ),
//   Product(
//     id: '9',
//     name: 'Apple MacBook Pro M3',
//     price: '1300',
//     image: 'images/pro-m2-pro-silver.jpg',
//   ),
//   Product(
//     id: '10',
//     name: 'Apple MacBook Pro M3',
//     price: '1300',
//     image: 'images/pro-m2-space-gray.jpg',
//   ),
// ];
