import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/components/card/service_card.dart';
import 'package:turbo_express/model/category.dart';
import 'package:turbo_express/model/service.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/screens/home/components/home_drawer.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> with TickerProviderStateMixin {
  List<Category> categories = [];
  List<Service> services = [];

  // ApiService _api = ApiService.getInstance();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    categories = box.get("categories");
    services = box.get("services");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    String getDescription(Service data) {
      if (locale == context.supportedLocales[0]) return data.descriptionEn;
      if (locale == context.supportedLocales[1]) return data.descriptionRu;
      if (locale == context.supportedLocales[2]) return data.descriptionUz;
      return data.descriptionRu;
    }

    String getTitle(Service data) {
      if (locale == context.supportedLocales[0]) return data.titleEn;
      if (locale == context.supportedLocales[1]) return data.titleRu;
      if (locale == context.supportedLocales[2]) return data.titleUz;
      return data.titleRu;
    }

    Tab getCategory(Category cat) {
      if (locale == context.supportedLocales[0]) return Tab(child: Text(cat.titleEn, style: basicStyle3));
      if (locale == context.supportedLocales[1]) return Tab(child: Text(cat.titleRu, style: basicStyle3));
      if (locale == context.supportedLocales[2]) return Tab(child: Text(cat.titleUz, style: basicStyle3));
      return Tab(child: Text(cat.titleRu, style: basicStyle3));
    }

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'servicesHeader',
            style: basicStyle3.copyWith(
              color: Colors.black,
            ),
          ).tr(),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: darkBlue,
                width: 4.0,
              ),
            ),
            isScrollable: true,
            tabs: List.generate(categories.length, (index) => getCategory(categories[index])),
          ),
        ),
        drawer: HomeDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Builder(
            builder: (context) {
              List<int> sizeOfServices = [];
              sizeOfServices = List.filled((services.length + 1), 0);
              for (int indexCategory = 0; indexCategory < categories.length; indexCategory++) {
                services.forEach(
                  (e) {
                    var tempIndex = indexCategory + 1;
                    return sizeOfServices[tempIndex] += (categories[indexCategory].id == e.category ? 1 : 0);
                  },
                );
              }
              List<List<Widget>> children = List.generate(categories.length, (i) {
                List<Widget> widgets = [];
                for (int j = 0; j < services.length; j++) {
                  if (services[j].category == categories[i].id) {
                    widgets.add(ServiceCard(
                      imageUrl: services[j].image,
                      title: getTitle(services[j]),
                      serviceDescription: getDescription(services[j]),
                      price: services[j].price,
                    ));
                  }
                }
                return widgets;
              });
              return TabBarView(
                children: List.generate(
                  categories.length,
                  (i) => ListView.builder(
                    itemCount: sizeOfServices[i + 1],
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 34.w,
                      ),
                      child: children[i][index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
