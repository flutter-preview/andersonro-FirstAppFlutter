import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {

  var battery = Battery();
  var batteryStatus = 0;
  var colorStatus = Colors;

  @override
  void initState() {
    super.initState();
    loadBattery();
  }

  loadBattery() async {
    batteryStatus = await battery.batteryLevel;

    if (batteryStatus < 20) {
      colorStatus = Colors.red as Type;
    } else if (batteryStatus >= 20 && batteryStatus <= 40) {
      colorStatus = Colors.blue as Type;
    } else {
      colorStatus = Colors.green as Type;
    }


    setState(() {});
    battery.onBatteryStateChanged.listen((BatteryState state) {
      print('STATE: ${state}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Status Battery ${batteryStatus.toString()}')),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: batteryStatus / 100,
                  center: Text("${batteryStatus}%"),
                  progressColor: Color(colorStatus.hashCode)
                ),
              ],
            ),
          ),
        )
    );
  }
}
