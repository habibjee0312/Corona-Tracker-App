import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_corona_tracker/Models/world_states.dart';
import 'package:my_corona_tracker/Services/world_services.dart';
import 'package:my_corona_tracker/view/countries_list.dart';
import 'package:pie_chart/pie_chart.dart';

class World extends StatefulWidget {
  const World({super.key});

  @override
  State<World> createState() => _WorldState();
}

class _WorldState extends State<World> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..forward();
  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to prevent memory leaks
    super.dispose();
  }
  final colorlist=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    WorldServices worldServices=WorldServices();
    return Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(15.0),
      child:Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          FutureBuilder<WorldStates>(
            future: worldServices.list(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.black,
                    controller: _controller,
                  ),

                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    PieChart(dataMap:  {
                      "total":double.parse(snapshot.data!.cases.toString()),
                      "Recovered":double.parse(snapshot.data!.recovered.toString()),
                      "Death":double.parse(snapshot.data!.deaths.toString()),

                    },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius:  MediaQuery.of(context).size.width / 3*2,
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      animationDuration: Duration(milliseconds:  1200),
                      chartType: ChartType.ring,
                      colorList: colorlist,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *.06),
                      child: Card(
                        child: Column(
                          children: [
                            Reusable(title: 'Total', value: snapshot.data!.cases.toString()),
                            Reusable(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            Reusable(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            Reusable(title: 'Active', value: snapshot.data!.active.toString()),
                            Reusable(title: 'Critical', value: snapshot.data!.critical.toString()),
                            Reusable(title: 'Today', value: snapshot.data!.todayCases.toString()),
                            Reusable(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString())
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }
              return const Text('No data');
            },
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()),);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff1aa260),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('See Countries'),
              ),
            ),
          )


        ],
      ) ,)
      ),
    );
  }
}
class Reusable extends StatelessWidget {
  String title , value;
   Reusable({ super.key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child:  Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),


            ],
          )
        ],
      ),
    );
  }
}

