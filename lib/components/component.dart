// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/flutter_flow_theme.dart';
import 'dart:math' as math;

class ClubCard extends StatelessWidget {
  final String id;
  final String name;
  final String category;
  final String desc;
  final String numevents;

  ClubCard({
    required this.id,
    required this.name,
    required this.category,
    required this.desc,
    required this.numevents,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      child: Container(
        width: 370,
        height: 170,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x4B1A1F24),
              offset: Offset(0, 2),
            )
          ],
          gradient: LinearGradient(
            colors: [
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              Color(0xFF4B39EF)
            ],
            stops: [0, 1],
            begin: AlignmentDirectional(0.94, -1),
            end: AlignmentDirectional(-0.94, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      id,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Roboto Mono',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                      softWrap: true,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Text(
                        category,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Roboto Mono',
                              color:
                                  Colors.black, // Adjust text color as needed
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                name,
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                desc,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Card(
    //   child: Column(
    //     children: [
    //       Text(
    //         name,
    //         overflow:
    //             TextOverflow.ellipsis, // Handle overflow by adding ellipsis
    //         maxLines: 1, // Restrict to a single line
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16,
    //         ),
    //       ),
    //       Text(
    //         category,
    //         style: TextStyle(
    //           fontStyle: FontStyle.italic,
    //         ),
    //       ),
    //       Text(
    //         'Events: $numevents',
    //         style: TextStyle(
    //           color: Colors.blue,
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           desc,
    //           overflow:
    //               TextOverflow.visible, // Allow overflow for the description
    //           softWrap: true, // Enable wrapping onto the next line
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class EventCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String place;
  final String date;
  final String time;
  final String type;
  final String clubName;

  EventCard({
    required this.id,
    required this.name,
    required this.place,
    required this.description,
    required this.date,
    required this.time,
    required this.type,
    required this.clubName,
  });
  final Color yourColor =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    // Generated code for this orderCard Widget...
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Color(0x34000000),
              offset: Offset(-2, 5),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 4,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: yourColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toUpperCase(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: yourColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          description,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          time,
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      place,
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                            child: Text(
                              date,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          clubName,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Card(
    //   color: AppColor.sky,
    //   margin: EdgeInsets.all(16),
    //   child: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(id),
    //         Text(
    //           name,
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         Text(description),
    //         Text(date),
    //         Text(time),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ForumPostCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String username;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isEdited;
  final bool isAuth;

  ForumPostCard({
    required this.title,
    required this.body,
    required this.date,
    required this.username,
    required this.onDelete,
    required this.onEdit,
    required this.isEdited,
    required this.isAuth,
  });

  void _onDelete() {
    onDelete();
    // Delete the forum post.
  }

  void _onEdit() {
    // Edit the forum post.
  }

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
                if (isEdited)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Edited',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (isAuth)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: _onDelete,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: _onEdit,
                      ),
                    ],
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

