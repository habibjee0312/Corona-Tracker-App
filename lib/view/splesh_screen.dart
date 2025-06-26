import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_corona_tracker/view/world.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..forward(); // Start the animation

  @override
  void initState() {
    super.initState();
    // Optional: Navigate to another screen after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Example: Navigate to the next screen
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
      }
    });
    Timer(const Duration(seconds: 5),
        () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>World()))
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Image(image: AssetImage('assets/image.png')),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              const Text(
                "COVID 19\nTracker App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class SpleshScreen extends StatefulWidget {
//   const SpleshScreen({super.key});
//
//   @override
//   State<SpleshScreen> createState() => _SpleshScreenState();
// }
//
// class _SpleshScreenState extends State<SpleshScreen> with TickerProviderStateMixin {
//   late final AnimationController _controller=AnimationController(
//     duration: const Duration(seconds: 3),
//       vsync: this
//   )..reset();
//
//   @override
//   void initState(){
//     super.initState();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           AnimatedBuilder(animation: _controller,
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 child: Image(image: AssetImage('assets/image.png')),
//               ),
//               builder: (BuildContext context,Widget child){
//             return Transform.rotate(
//                 angle: _controller.value*2.0*math.pi,
//               child: child,
//             );
//               });
//           SizedBox(height: MediaQuery.of(context).size.height*.08,),
//     Text("COVID 19\nTracker App",style: TextStyle()),
//         ],
//
//       ),
//     );
//   }
// }
