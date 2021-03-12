import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:turbo_express/common/constants.dart';
import 'package:turbo_express/common/functions/show_snackbar.dart';
import 'package:turbo_express/components/card/service_card.dart';
import 'package:turbo_express/model/category.dart';
import 'package:turbo_express/model/service.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/model/user_wash.dart';
import 'package:turbo_express/model/user_wash_item.dart';
import 'package:turbo_express/model/washing.dart';
import 'package:turbo_express/res/color.dart';
import 'package:turbo_express/res/style.dart';
import 'package:turbo_express/services/api/api.dart';

class CreateUserWashBody extends StatefulWidget {
  @override
  _CreateUserWashBodyState createState() => _CreateUserWashBodyState();
}

class _CreateUserWashBodyState extends State<CreateUserWashBody>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Category> _categories = [];
  List<Service> _services = [];
  List<Washing> washings = [];
  var api = ApiService.getInstance();
  List<Service> _selectedServices = [];
  Washing _selectedPackage;
  String templateTitle = "";
  double _totalPrice = 0.0;
  int _selectedPackageId;
  int _selectedPackageIndex = 0;
  User user;

  var _titleController = TextEditingController();

  @override
  void initState() {
    var box = Hive.box(Constants.API_BOX);
    user = box.get("userInfo");
    washings = box.get("washings");
    _totalPrice += washings[_selectedPackageIndex].total.toDouble();
    _services = box.get("services");
    _categories = box.get("categories");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _titleController.text = templateTitle;
    final locale = context.locale;
    final size = MediaQuery.of(context).size;
    String getDescription(Service data) {
      if (locale == context.supportedLocales[0]) return data.descriptionEn;
      if (locale == context.supportedLocales[1]) return data.descriptionRu;
      if (locale == context.supportedLocales[2]) return data.descriptionUz;
      return data.descriptionRu;
    }

    String getTitle(dynamic data) {
      if (locale == context.supportedLocales[0]) return data.titleEn;
      if (locale == context.supportedLocales[1]) return data.titleRu;
      if (locale == context.supportedLocales[2]) return data.titleUz;
      return data.titleRu;
    }

    Tab getCategoryTab(Category cat) {
      if (locale == context.supportedLocales[0]) return Tab(child: Text(cat.titleEn, style: basicStyle3));
      if (locale == context.supportedLocales[1]) return Tab(child: Text(cat.titleRu, style: basicStyle3));
      if (locale == context.supportedLocales[2]) return Tab(child: Text(cat.titleUz, style: basicStyle3));
      return Tab(child: Text(cat.titleRu, style: basicStyle3));
    }

    /// washing future
    return Builder(builder: (context) {
      List<int> sizeOfServices = List.filled((_services.length + 1), 0);

      _selectedPackageId = washings[_selectedPackageIndex].id;
      _selectedPackage = washings[_selectedPackageIndex];

      var totalPriceMask =
          NumberFormat.currency(symbol: '', decimalDigits: _totalPrice.toString().indexOf('.') == -1 ? 0 : 0)
              .format(num.parse(_totalPrice.toString()));

      /// calculating size of services by category
      for (int indexCategory = 0; indexCategory < _categories.length; indexCategory++) {
        _services.forEach(
          (e) {
            var tempIndex = indexCategory + 1;
            return sizeOfServices[tempIndex] += (_categories[indexCategory].id == e.category ? 1 : 0);
          },
        );
      }

      /// sorting services by category and adding to double list
      List<List<Widget>> children = List.generate(_categories.length, (i) {
        List<Widget> widgets = [];
        for (int j = 0; j < _services.length; j++) {
          if (_services[j].category == _categories[i].id) {
            widgets.add(ServiceCard(
              isSelected: _selectedServices.contains(_services[j]),
              onTap: (bool save) {
                if (save) {
                  _selectedServices.add(_services[j]);
                  setState(() {
                    _totalPrice += _services[j].price;
                  });
                } else {
                  _selectedServices.remove(_services[j]);
                  setState(() {
                    _totalPrice -= _services[j].price;
                  });
                }
              },
              data: _services[j],
              imageUrl: _services[j].image,
              title: getTitle(_services[j]),
              serviceDescription: getDescription(_services[j]),
              price: _services[j].price,
            ));
          }
        }
        return widgets;
      });

      /// UI
      return Column(
        children: [
          /// Title
          Padding(
            padding: EdgeInsets.only(left: 34.w, right: 34.w, top: 24.h),
            child: Text("packageOfServices", style: basicStyle2).tr(),
          ),

          /// Packages carousel
          CarouselSlider.builder(
            itemCount: washings.length,
            itemBuilder: (context, i0, i1) {
              return Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 42.h),
                            height: 230.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(washings[i0].image),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Card(
                              shape: CircleBorder(),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(16.h),
                                child: SvgPicture.network(
                                  washings[i0].icon,
                                  height: 64.h,
                                  width: 64.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getTitle(washings[i0]),
                        style: basicStyle3.copyWith(fontSize: 38.ssp),
                      ),
                      // Text("от 20 минут", style: basicStyle1.copyWith(color: Colors.grey, fontSize: 28.ssp)),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 400.h,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                _totalPrice -= washings[_selectedPackageIndex].total;
                _selectedPackageIndex = index;
                _selectedPackageId = washings[index].id;
                _selectedPackage = washings[index];
                setState(() {
                  _totalPrice += washings[_selectedPackageIndex].total.toDouble();
                });
              },
              // onScrolled: (value) => showSnackBar(context, "some value $value"),
            ),
          ),

          /// Some space
          SizedBox(height: 12.h),

          /// Category and services under default controller
          DefaultTabController(
            length: _categories.length,
            child: Column(
              children: [
                TabBar(
                  overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                  labelStyle: basicStyle3.copyWith(color: Colors.black),
                  unselectedLabelStyle: basicStyle3.copyWith(color: Colors.black),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 3.0,
                  tabs: _categories.map((e) => getCategoryTab(e)).toList(),
                ),

                /// there are services
                LimitedBox(
                  maxHeight: 450.h,
                  maxWidth: ScreenUtil().screenWidth,
                  child: TabBarView(
                    children: List.generate(
                      _categories.length,
                      (i) => ListView.builder(
                        itemCount: sizeOfServices[i + 1],
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 34.w),
                          child: children[i][index],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Bottom widget with total price and play button
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  /// bottom Sheet Dialog
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.h),
                                child: Text(
                                  "newTemplate",
                                  style: basicStyle4,
                                ).tr(),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
                                decoration: BoxDecoration(boxShadow: kElevationToShadow[24]),
                                child: TextField(
                                  controller: _titleController,
                                  onChanged: (value) {
                                    templateTitle = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "templateName".tr(),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height * 0.3,
                                width: size.width,
                                margin: EdgeInsets.symmetric(horizontal: 34.w),
                                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: skyBlue, width: 2.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: skyBlue, width: 4.0),
                                          ),
                                          child: Icon(FontAwesomeIcons.car, size: 24),
                                        ),
                                        Text(getTitle(_selectedPackage), style: basicStyle2),
                                        Text(
                                          "$totalPriceMask UZS",
                                          style: basicStyle3.copyWith(color: skyBlue),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    LimitedBox(
                                      maxHeight: 240.h,
                                      maxWidth: ScreenUtil().screenWidth,
                                      child: ListView.builder(
                                          itemCount: _selectedServices.length,
                                          itemBuilder: (context, index) => Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        getTitle(_selectedServices[index]),
                                                        style: basicStyle0,
                                                      ),
                                                      Text(
                                                        getDescription(_selectedServices[index]),
                                                        style: basicStyle0.copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 18.ssp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      var priceMask = NumberFormat.currency(
                                                              symbol: '',
                                                              decimalDigits: _selectedServices[index]
                                                                          .price
                                                                          .toString()
                                                                          .indexOf('.') ==
                                                                      -1
                                                                  ? 0
                                                                  : 0)
                                                          .format(num.parse(_selectedServices[index].price.toString()));
                                                      return Text("$priceMask UZS",
                                                          style: basicStyle3.copyWith(color: skyBlue));
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.delete_sweep, color: Colors.redAccent),
                                                    onPressed: () {
                                                      var deleteItem = _selectedServices[index];
                                                      _selectedServices.remove(deleteItem);
                                                    },
                                                  ),
                                                ],
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.h),
                                child: Text(
                                  "cost",
                                  style: basicStyle4.copyWith(color: skyBlue),
                                ).tr(args: [":"], namedArgs: {'price': '$totalPriceMask', 'currencyCode': 'UZS'}),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  color: skyBlue,
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 34.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.money, color: skyBlue),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "total",
                            style: basicStyle4.copyWith(color: Colors.white),
                          ).tr(),
                          Builder(
                            builder: (context) {
                              totalPriceMask = NumberFormat.currency(
                                      symbol: '', decimalDigits: _totalPrice.toString().indexOf('.') == -1 ? 0 : 0)
                                  .format(num.parse(_totalPrice.toString()));
                              return Text(
                                "$totalPriceMask UZS",
                                style: basicStyle5.copyWith(color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                      RawMaterialButton(
                        padding: EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.play_arrow,
                          color: skyBlue,
                          size: 32,
                        ),
                        onPressed: () {
                          List<UserWashItem> items = _selectedServices.map((element) {
                            return UserWashItem(
                              count: 1,
                              serviceItem: element,
                            );
                          }).toList();
                          UserWash temp = UserWash(
                            title: templateTitle,
                            washing: _selectedPackageId,
                            userWashItem: items,
                            user: user.id,
                            isDefault: false,
                            status: 0,
                          );
                          api.createTemplate(temp).then((statusCode) {
                            if (statusCode == 201) {
                              showSnackBar(context, "template created");
                              Timer(const Duration(seconds: 1), () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                Navigator.pop(context);
                              });
                            } else
                              showSnackBar(context, "template creating failed");
                            Timer(
                                const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                          }, onError: (error) {
                            print(error.toString());
                            showSnackBar(context, error.toString());
                            Timer(
                                const Duration(seconds: 1), () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: 48.h),
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
