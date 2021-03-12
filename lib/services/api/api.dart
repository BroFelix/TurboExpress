import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/get_token.dart';
import 'package:turbo_express/common/functions/get_user.dart';
import 'package:turbo_express/model/bank_card.dart';
import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/car_type.dart';
import 'package:turbo_express/model/category.dart';
import 'package:turbo_express/model/data_source.dart';
import 'package:turbo_express/model/news.dart';
import 'package:turbo_express/model/order.dart';
import 'package:turbo_express/model/order_in_progress.dart';
import 'package:turbo_express/model/service.dart';
import 'package:turbo_express/model/source.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_card.dart';
import 'package:turbo_express/model/user_wash.dart';
import 'package:turbo_express/model/washing.dart';

class ApiService {
  ApiService._();

  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      _instance = ApiService._();
    }
    return _instance;
  }

  final apiUrl = "${Constants.serverUrl}/api/v1";
  String username = 'admin';
  String password = 'adminadmin';
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:adminadmin'));

  Future<int> addCar({@required Car car}) async {
    final url = '$apiUrl/car/';
    final token = await getToken();
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.contentEncodingHeader: "charset=utf-8",
      },
      body: jsonEncode(car.toJson()),
    );
    print(response.body);
    return response.statusCode;
  }

  Future<List<Car>> getCars() async {
    final int userId = await getUser();
    final token = await getToken();
    final url = '$apiUrl/car/?user=$userId';
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'JWT $token',
    });
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    print(response.body);
    List<Car> objects = [];
    responseObj.forEach((e) {
      var object = Car.fromJson(e);
      objects.add(object);
    });
    return objects;
  }

  Future<List<CarType>> getCarTypes() async {
    final url = '$apiUrl/car_type/';
    final token = await getToken();
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<CarType> types = [];
    responseObj.forEach((e) => types.add(CarType.fromJson(e)));
    return types;
  }

  Future sendOrder({@required Order order}) async {
    final url = '$apiUrl/order/';
    final token = await getToken();
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(order.toJson()),
    );
    // print(response.body);
    return response.statusCode;
  }

  Future<List<Order>> getOrders() async {
    final token = await getToken();
    final url = '$apiUrl/order/';
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Order> orders = [];
    responseObj.forEach((e) => orders.add(Order.fromJson(e)));
    return orders;
  }

//  Future<List<OrderItem>> getOrderItems() async {
//    var token = await getToken();
//    final url = '$apiUrl/order_item/';
//    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: basicAuth});
//    final responseBody = utf8.decode(response.bodyBytes);
//    final responseObj = json.decode(responseBody);
//    var orders = List<OrderItem>();
//    responseObj.forEach((e) => orders.add(OrderItem.fromJson(e)));
//    return orders;
//  }

  Future<List<Category>> getCategories() async {
    final url = '$apiUrl/category/';
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: basicAuth});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Category> categories = [];
    responseObj.forEach((e) => categories.add(Category.fromJson(e)));
    // print(response.body);
    return categories;
  }

  Future<List<Washing>> getWashings() async {
    final url = '$apiUrl/washing/';
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: basicAuth},
    );
    // print("Fetched data from http");
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Washing> washings = [];
    responseObj.forEach((e) {
      // print(Washing.fromJson(e).runtimeType);
      washings.add(Washing.fromJson(e));
    });
    // responseObj.forEach((e) => print(e["washing_temp_item"].runtimeType));
    // print(response.body);
    return washings;
  }

  Future<List<Service>> getServices() async {
    final url = '$apiUrl/service/';
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: basicAuth});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Service> serviceList = [];
    responseObj.forEach((e) => serviceList.add(Service.fromJson(e)));
    // print(response.body);
    return serviceList;
  }

  Future<User> getUserInfo() async {
    int userId = await getUser();
    final url = '$apiUrl/user/$userId/';
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: basicAuth},
    );
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = jsonDecode(responseBody);
    return User.fromJson(responseObj);
  }

  Future<List<News>> getNews() async {
    final url = '$apiUrl/news/';
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<News> news = [];
    responseObj.forEach((e) => news.add(News.fromJson(e)));
    return news;
  }

  Future<List<UserCard>> getUserCardInfo() async {
    final int userId = await getUser();
    final url = '$apiUrl/user_card/?user=$userId';
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<UserCard> userCards = [];
    // print(response.body);
    responseObj.forEach((e) => userCards.add(UserCard.fromJson(e)));
    return userCards;
  }

  Future replenishBalance({int userId, String replenishSum}) async {
    final url = '$apiUrl/user/$userId/user_balance_replenishment/';
    replenishSum = replenishSum.replaceAll(" ", "").trim();
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "json/application",
        HttpHeaders.contentEncodingHeader: "charset=utf-8",
      },
      body: {
        "replenishment": replenishSum,
        "debit_card_item": "",
      },
    );
    return response.statusCode;
  }

  Future sendCard(BankCard bankCard) async {
    final url = '$apiUrl/user_debit_card/';
    var response = await http.post(
      url,
      // headers: {HttpHeaders.contentTypeHeader: "json/application"},
      body: <String, String>{
        "pan": bankCard.pan.toString(),
        "expire_date": bankCard.expireDate.toString(),
        "card_name": bankCard.cardName.toString(),
        "full_name": bankCard.fullName.toString(),
        "card_type": 1.toString(),
        "is_main": false.toString(),
        "user": bankCard.user.toString(),
      },
    );
    print(response.body);
    return response.statusCode;
  }

  Future<List<BankCard>> getBankCards() async {
    final int userId = await getUser();
    final url = '$apiUrl/user_debit_card/?user=$userId';
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    // print(response.body);
    List<BankCard> cardList = [];
    responseObj.forEach((e) => cardList.add(BankCard.fromJson(e)));
    return cardList;
  }

  Future addOrderInProgress(OrderInProgress newOrder) async {
    final url = '$apiUrl/order_in_progress/';
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentEncodingHeader: 'charset=utf-8',
      },
      body: jsonEncode(newOrder.toJson()),
    );
    // print(response.body);
    return response.statusCode;
  }

  Future<List<OrderInProgress>> getOrdersInProgress() async {
    final int userId = await getUser();
    final url = '$apiUrl/order_in_progress/?user=$userId';
    var response = await http.get(url);
    List<OrderInProgress> orders = [];

    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);

    responseObj.forEach((e) {
      var temp = OrderInProgress.fromJson(e);
      orders.add(temp);
    });
    return orders;
  }

  Future<List<Washing>> getWashingItems() async {
    final url = "$apiUrl/washing_item/";
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Washing> washingItems = [];
    responseObj.forEach((e) {
      var temp = Washing.fromJson(e);
      washingItems.add(temp);
    });
    return washingItems;
  }

  Future<List<Order>> getCompleteOrders() async {
    final userId = await getUser();
    final token = await getToken();
    final url = "$apiUrl/user/$userId/end_orders";
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'JWT $token'});
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<Order> orders = [];
    responseObj.forEach((element) => orders.add(Order.fromJson(element)));
    return orders;
  }

  Future<List<UserWash>> getUserWashes() async {
    final int userId = await getUser();
    final url = '$apiUrl/user_wash/?user=$userId';
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = json.decode(responseBody);
    List<UserWash> templates = [];
    responseObj.forEach((e) {
      templates.add(UserWash.fromJson(e));
    });
    return templates;
  }

  Future createTemplate(UserWash payload) async {
    final url = "$apiUrl/user_wash/";
    print(jsonEncode(payload.toJson()).toString());
    var response = await http.post(
      url,
      headers: <String, String>{
        // "accept": "json/application",
        // HttpHeaders.contentTypeHeader: "json/application",
        // HttpHeaders.contentEncodingHeader: "charset=utf-8",
      },
      body: <String, String>{
        "title": payload.title,
        "status": payload.status.toString(),
        "is_default": payload.isDefault.toString(),
        "user": payload.user.toString(),
        "washing": payload.washing.toString()
      },
    );
    print(response.body);
    return response.statusCode;
  }

  Future<Source> getAllData() async {
    final url = "$apiUrl/main/";
    var response = await http.get(url);
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = jsonDecode(responseBody);
    return Source.fromJson(responseObj);
  }

  Future<DataSource> getAllUserData() async {
    var user = await getUser();
    final url = "$apiUrl/user/main/$user";
    var response = await http.get(url).catchError((error) {
      print(error.toString());
    });
    final responseBody = utf8.decode(response.bodyBytes);
    final responseObj = jsonDecode(responseBody);
    // print(response.body);
    return DataSource.fromJson(responseObj);
  }
}
