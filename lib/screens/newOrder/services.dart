// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:turbo_express/components/car/number/car_number.dart';
// import 'package:turbo_express/components/card/service_package_card.dart';
// import 'package:turbo_express/components/service_item.dart';
// import 'package:turbo_express/model/car.dart';
// import 'package:turbo_express/model/service.dart';
// import 'package:turbo_express/model/washing.dart';
// import 'package:turbo_express/res/color.dart';
// import 'package:turbo_express/res/style.dart';
// import 'package:turbo_express/screens/newOrder/orderInfoScreen.dart';
// import 'package:turbo_express/services/api/api.dart';
//
// class ServicesPage extends StatefulWidget {
//   final Car car;
//
//   ServicesPage({@required this.car});
//
//   @override
//   _ServicesState createState() => _ServicesState();
// }
//
// class _ServicesState extends State<ServicesPage> with TickerProviderStateMixin {
//   List<bool> _selectedServices = List.generate(100, (i) => false);
//   Future<List<Service>> _services = Future.value(null);
//   Future<List<Washing>> _washings = Future.value(null);
//   ApiService _api = ApiService.getInstance();
//   TabController _tabController;
//   int _selectedPackage;
//   double _total = 0.0;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     _services = _api.getServices();
//     _washings = _api.getWashings();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'servicesHeader',
//           style: basicStyle4.copyWith(color: Colors.black),
//         ).tr(),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 24.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/icons/sedan.svg',
//                                 height: 32.h,
//                               ),
//                               SizedBox(height: 16),
//                               Text(
//                                 widget.car.title,
//                                 style: basicStyle1.copyWith(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           CarNumber(
//                             label: widget.car.carNumber,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border(bottom: BorderSide(color: Colors.black12, width: 2.0))),
//                       margin: EdgeInsets.symmetric(
//                         // horizontal: 24.w,
//                         vertical: 16.h,
//                       ),
//                       height: 65.h,
//                       width: ScreenUtil().screenWidth,
//                       child: TabBar(
//                         indicatorSize: TabBarIndicatorSize.label,
//                         indicator: UnderlineTabIndicator(
//                           borderSide: BorderSide(color: darkBlue, width: 2.0),
//                         ),
//                         controller: _tabController,
//                         isScrollable: true,
//                         unselectedLabelStyle: defaultStyle.copyWith(color: textGrey),
//                         tabs: [
//                           Tab(
//                             child: Text(
//                               'packages',
//                               style: basicStyle3.copyWith(color: Colors.black),
//                             ).tr(),
//                           ),
//                           Tab(
//                             child: Text(
//                               'services',
//                               style: basicStyle3.copyWith(color: Colors.black),
//                             ).tr(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: .6.sh,
//                       width: ScreenUtil().screenWidth,
//                       child: TabBarView(
//                         physics: PageScrollPhysics(),
//                         controller: _tabController,
//                         children: [
//                           FutureBuilder(
//                             future: _washings,
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 var data = snapshot.data as List<Washing>;
//                                 return ListView.builder(
//                                   itemCount: data.length,
//                                   itemBuilder: (context, index) => GestureDetector(
//                                     onTap: () {
//                                       if (_selectedPackage != null) {
//                                         _total -= data[_selectedPackage].total;
//                                       }
//                                       setState(() {
//                                         _selectedPackage = index;
//                                         _total += data[_selectedPackage].total;
//                                       });
//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: 24.w),
//                                       child: ServicePackage(
//                                         packageTitle: data[index].titleRu,
//                                         packagePrice: data[index].total,
//                                         selected: _selectedPackage == index,
//                                         // packageTime: data[index].washingTempItem.time,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               return Container();
//                             },
//                           ),
//                           FutureBuilder(
//                             future: _services,
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 var data = snapshot.data as List<Service>;
//                                 return ListView.builder(
//                                   itemCount: data.length,
//                                   itemBuilder: (context, index) => Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             _selectedServices[index] = !_selectedServices[index];
//                                             if (_selectedServices[index])
//                                               _total += data[index].price;
//                                             else
//                                               _total -= data[index].price;
//                                           });
//                                         },
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(horizontal: 24.w),
//                                           child: ServiceItem(
//                                             serviceName: data[index].titleRu,
//                                             servicePrice: data[index].price.toString(),
// //                                    serviceTime: data[index].,
//                                             selected: _selectedServices[index],
//                                           ),
//                                         ),
//                                       ),
//                                       Divider(
//                                         thickness: 2.0,
//                                         color: Colors.black12,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//                               return Container();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Итого:",
//                                   style: basicStyle3,
//                                 ),
//                                 Text(
//                                   "$_total сум",
//                                   style: basicStyle3,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(16.h),
//                             child: MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               height: 84.h,
//                               minWidth: MediaQuery.of(context).size.width,
//                               color: Colors.blue,
//                               textColor: Colors.white,
//                               child: Text(
//                                 'verify',
//                                 style: buttonTextStyle,
//                               ).tr(),
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .push(new MaterialPageRoute(builder: (context) {
//                                   return OrderInfoScreen();
//                                 }));
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
