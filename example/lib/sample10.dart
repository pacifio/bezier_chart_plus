import 'dart:convert';

import 'package:bezier_chart_plus/bezier_chart_plus.dart';
import 'package:flutter/material.dart';

class Sample10 extends StatefulWidget {
  const Sample10({super.key});

  @override
  State<Sample10> createState() => _Sample10State();
}

class _Sample10State extends State<Sample10> {
  List<DataPoint>? _items;
  List<double>? _xAxis;

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    const String data =
        '[{"Day":1,"Value":"5"},{"Day":2,"Value":"2"},{"Day":3,"Value":"6"},{"Day":4,"Value":"8"}]';
    final List? list = json.decode(data);
    setState(() {
      _items = list!
          .map((item) => DataPoint(
              value: double.parse(item["Value"].toString()),
              xAxis: double.parse(item["Day"].toString())))
          .toList();
      _xAxis =
          list.map((item) => double.parse(item["Day"].toString())).toList();
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _items != null
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.black87,
                    Colors.black87,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Async Bezier Chart Plus - Numbers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Center(
                    child: Card(
                      elevation: 12,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: BezierChart(
                          bezierChartScale: BezierChartScale.custom,
                          xAxisCustomValues: _xAxis,
                          footerValueBuilder: (double value) {
                            return "${formatAsIntOrDouble(value)}\ndays";
                          },
                          series: [
                            BezierLine(
                              label: "m",
                              data: _items!,
                            ),
                          ],
                          config: BezierChartConfig(
                            startYAxisFromNonZeroValue: false,
                            bubbleIndicatorColor: Colors.white.withOpacity(0.9),
                            footerHeight: 40,
                            verticalIndicatorStrokeWidth: 3.0,
                            verticalIndicatorColor: Colors.black26,
                            showVerticalIndicator: true,
                            verticalIndicatorFixedPosition: false,
                            displayYAxis: true,
                            stepsYAxis: 1,
                            backgroundGradient: LinearGradient(
                              colors: [
                                Colors.red[300]!,
                                Colors.red[400]!,
                                Colors.red[400]!,
                                Colors.red[500]!,
                                Colors.red,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            snap: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
