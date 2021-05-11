import 'package:flutter/material.dart';

import 'imageCompareScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Compare'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageCompare(),
                    ),
                  );
                },
                child: Text(
                  "Compare 3 Images",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
