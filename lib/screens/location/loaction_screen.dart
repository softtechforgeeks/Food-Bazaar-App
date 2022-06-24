import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/svg.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocationScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(1.556434544618297, 103.64029183992822),
                zoom: 10,
              ),
            ),
          ),
          Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/googlemaps.svg',
                      height: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: LocationSearchBox()),
                  ],
                ),
              )),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                child: Text('Save'),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter your Location',
          suffixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.only(
            left: 20,
            bottom: 5,
            right: 5,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 245, 245, 245),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 143, 5, 5)),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
