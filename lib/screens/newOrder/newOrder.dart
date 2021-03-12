// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:turbo_express/components/car/car_card.dart';
// import 'package:turbo_express/model/car.dart';
// import 'package:turbo_express/res/style.dart';
// import 'package:turbo_express/screens/newOrder/services.dart';
// import 'package:turbo_express/services/api/api.dart';
//
// class NewOrderPage extends StatefulWidget {
//   @override
//   _NewOrderPageState createState() => _NewOrderPageState();
// }
//
// class _NewOrderPageState extends State<NewOrderPage> {
//   Future<List<Car>> _cars = Future.value(null);
//   ApiService _api = ApiService.getInstance();
//   var _selectedItem;
//   var car;
//
//   @override
//   void initState() {
//     _cars = _api.getCars();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         title: Text('newOrder'.tr(), style: headerStyle.copyWith(fontSize: 60.ssp)),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.close,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_horiz, color: Colors.black),
//             onPressed: () async {
//               await showMenu(
//                   context: context,
//                   position: RelativeRect.fromLTRB(100, 75, 0, 100),
//                   items: [
//                     PopupMenuItem(child: Text('View')),
//                     PopupMenuItem(child: Text('Edit')),
//                     PopupMenuItem(child: Text('Delete')),
//                   ]);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 24.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 24.h,
//                           horizontal: 24.w,
//                         ),
//                         child: Text(
//                           'chooseCar'.tr(),
//                           style: basicStyle4,
//                         ),
//                       ),
//                     ),
//                     Divider(color: Colors.black12, thickness: 1.0),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 24.h),
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints.tight(
//                           Size(ScreenUtil().screenWidth, 750.h),
//                         ),
//                         child: FutureBuilder(
//                           future: _cars,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               var data = snapshot.data;
//                               return ListView.builder(
//                                 itemCount: data.length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() => _selectedItem = index);
//                                         car = data[_selectedItem];
// //                                      if (_selectedItems.contains(data[index])) {
// //                                        setState(() => _selectedItems.remove(data[index]));
// //                                      } else {
// //                                        setState(() => _selectedItems.add(data[index]));
// //                                      }
//                                       },
//                                       child: CarItemCard(
//                                         carNumber: data[index].carNumber,
//                                         carName: data[index].title,
//                                         check: _selectedItem == index,
// //                                      _selectedItems.contains(data[index]),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             }
//                             return Container();
//                           },
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                       ),
//                       height: 55,
//                       minWidth: MediaQuery.of(context).size.width,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       child: Text(
//                         'next',
//                         style: buttonTextStyle,
//                       ).tr(),
//                       onPressed: () {
//                         if (_selectedItem != null) {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                             return ServicesPage(car: car);
//                           }));
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
