import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // child: GestureDetector(
        //   onTap: (){
        //     Navigator.pushNamed(context, '/main');
        //   },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Color(0xff860000),
              ),
              child: Center(
                widthFactor: 100.0,
                heightFactor: 100.0,
                child: Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'All in one platform for',
                style: TextStyle(
                  color: Color(0xff860000),
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'IOE Syllabus,Notes,Notices & more!',
                style: TextStyle(
                  color: Color(0xff860000),
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
