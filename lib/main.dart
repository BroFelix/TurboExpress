import 'package:cool_ui/cool_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turbo_express/app.dart';
import 'package:turbo_express/components/keyboard/custom_keyboard.dart';
import 'package:turbo_express/model/bank_card.dart';
import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/car_type.dart';
import 'package:turbo_express/model/category.dart';
import 'package:turbo_express/model/news.dart';
import 'package:turbo_express/model/order.dart';
import 'package:turbo_express/model/order_in_progress.dart';
import 'package:turbo_express/model/order_wash_item.dart';
import 'package:turbo_express/model/service.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_card.dart';
import 'package:turbo_express/model/user_wash.dart';
import 'package:turbo_express/model/user_wash_item.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/model/washing_item.dart';
import 'package:turbo_express/model/washing_temp_item.dart';

import 'common/constants.dart';

void main() async {
  /// widgets ensuring something
  WidgetsFlutterBinding.ensureInitialized();

  /// Hive database and TypeAdapters initialization
  await Hive.initFlutter();
  Hive.registerAdapter(BankCardAdapter());
  Hive.registerAdapter(CarAdapter());
  Hive.registerAdapter(CarTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(NewsAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderInProgressAdapter());
  Hive.registerAdapter(OrderWashItemAdapter());
  Hive.registerAdapter(ServiceAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserCardAdapter());
  Hive.registerAdapter(UserWashAdapter());
  Hive.registerAdapter(UserWashItemAdapter());
  Hive.registerAdapter(WashingAdapter());
  Hive.registerAdapter(WashingItemAdapter());
  Hive.registerAdapter(WashingTempItemAdapter());
  await Hive.openBox(Constants.API_BOX);

  /// Custom numerical keyboard registering
  CustomKeyboard.register();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: KeyboardRootWidget(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}
