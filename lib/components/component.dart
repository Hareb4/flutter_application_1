
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class EventCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;

  EventCard({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.sky,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(id),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(description),
            Text(date),
            Text(time),
          ],
        ),
      ),
    );
  }
}

class ForumPostCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String username;

  ForumPostCard({
    required this.title,
    required this.body,
    required this.date,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForumCommentCard extends StatelessWidget {
  final String comment;
  final String date;
  final String username;

  ForumCommentCard({
    required this.comment,
    required this.date,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.sky,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comment by $username',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              comment,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
