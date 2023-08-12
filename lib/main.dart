import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Scale Transition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  bool visible = true;
  late Color backgroundColor ;

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 1, end: 18).animate(_controller);
    backgroundColor = _generateRandomColor();
  }

  void handleOnTop() async {
    visible = false;
    _controller.animateTo(1, curve: Curves.ease).then((value) {
      setState(() {
        backgroundColor = _generateRandomColor();
        visible = true;
      });
    });

    // _controller.animateTo(1, curve: Curves.ease).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2(),)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
_controller.reset();
visible = true;
    return Scaffold(
     body: Center(child: InkWell(onTap: handleOnTop,
       child: AnimatedBuilder(
         animation: _controller,
         builder: (context, child) {
           return Transform.scale(
             scale: _animation.value,
             child: CircleAvatar(
               radius: 30,
               backgroundColor: backgroundColor,
               child: Visibility(
                 visible: visible,
                 child: Icon(
                   Icons.add,
                   color: Colors.white,
                   size: 38,
                 ),
               ),
             ),
           );
         },
       ),
     ),), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




// Page 2
class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Container(color: Colors.white,
    child: Text('Page 2'),),);
  }
}
