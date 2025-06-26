

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_corona_tracker/Services/world_services.dart';
import 'package:my_corona_tracker/view/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldServices worldServices = WorldServices();
    return  Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search for Countries',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )

                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: worldServices.countriesList(),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                             child: Column(
                            children: [
                            ListTile(
                              title:Container(height: 10,width: 85, color: Colors.white,),
                              subtitle:Container(height: 10,width: 85, color: Colors.white,),
                              leading: Container(height: 50,width: 50, color: Colors.white,)
                            ),
                          ],
                             )
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error.toString()}'),
                    );
                  } else if (snapshot.hasData) {

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name=snapshot.data![index]['country'];
                        if(_controller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,)));
                          },
                                child: ListTile(
                                  title:Text(snapshot.data![index]['country']),
                                  subtitle:Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              ),
                            ],
                          );
                        }
                        else if(name.toLowerCase().contains(_controller.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (Context)=>DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'] ,
                                      totalCases:  snapshot.data![index]['cases'] ,
                                      totalRecovered: snapshot.data![index]['recovered'] ,
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],

                                  )));
                          },
                                child: ListTile(
                                  title:Text(snapshot.data![index]['country']),
                                  subtitle:Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return Container();
                        }

                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
