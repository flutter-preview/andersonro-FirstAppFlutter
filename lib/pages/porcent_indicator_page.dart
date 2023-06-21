import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PorcentIndicatorPage extends StatefulWidget {
  const PorcentIndicatorPage({super.key});

  @override
  State<PorcentIndicatorPage> createState() => _PorcentIndicatorPageState();
}

class _PorcentIndicatorPageState extends State<PorcentIndicatorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Indicadores Porcentagem"),),
          body: Center(
            child: ListView(
              children: [
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: 0.8,
                  header: const Text("Icon header"),
                  center: const Icon(
                    Icons.person_pin,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                CircularPercentIndicator(
                  radius: 130.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 15.0,
                  percent: 0.4,
                  center: const Text(
                    "40 hours",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.yellow,
                  progressColor: Colors.red,
                ),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: 0.7,
                  center: const Text(
                    "70.0%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: const Text(
                    "Sales this week",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                Center(
                  child: LinearPercentIndicator(
                    width: 170.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: new Text("left content"),
                    trailing: new Text("right content"),
                    percent: 0.2,
                    center: Text("20.0%"),
                    // ignore: deprecated_member_use
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.red,
                  ),
                )
                
              ],
            ),
          ),
        )
    );
  }
}
