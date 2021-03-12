import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_express/res/style.dart';

class ServiceItem extends StatelessWidget {
  final String serviceName;
  final serviceTime;
  final servicePrice;
  final bool selected;

  ServiceItem({
    this.serviceName = 'Tire Dressing ',
    this.serviceTime = '• 5 min',
    this.servicePrice = '\$4.25',
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                serviceName,
                style: titleStyle.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(serviceTime),
            ],
          ),
          Text(
            servicePrice,
            style: basicStyle3,
          ),
          Container(
            padding: selected ? EdgeInsets.all(4.0) : EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.green : Colors.white,
              border: selected ? null : Border.all(color: Colors.black12, width: 2.0),
            ),
            child: selected
                ? Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
