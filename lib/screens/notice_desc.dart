import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';

import '../MyColors.dart';

class NoticeDescription extends StatelessWidget {
  var content;
  NoticeDescription(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice Detail'),
        centerTitle: true,
        backgroundColor: MyColor.PrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              content['notice_title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .format(DateTime.parse(content["created_at"])),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.person, color: Colors.grey[600]),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Author : ${content['author']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Html(
              data: content['description'],
              style: {
                'p': Style(
                  fontSize: FontSize(20.0),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
