import 'package:creator_mind/core/global/date.dart';
import 'package:creator_mind/features/attendence/domain/entities/attendance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../attendence/presentation/bloc/attendance_bloc.dart';
import '../../../attendence/presentation/bloc/attendance_event.dart';
import '../../../attendence/presentation/bloc/attendance_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const ivsPlaybackUrl =
      'https://0befe6448bce.ap-south-1.playback.live-video.net/api/video/v1/ap-south-1.934216310591.channel.opcWa3cSK4yQ.m3u8';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final date = getFormattedDate();
    var userData = {};
    getUser().then((value) {
      if(value!= null) {
        userData.addAll(value);
      }
    },);

    context.read<AttendanceBloc>().add(
      WatchMyAttendanceEvent(
        "${user?.uid}", date,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          user?.email ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 12),

                        BlocBuilder<AttendanceBloc, AttendanceState>(
                          builder: (context, state) {
                            if (state is AttendanceLoading) {
                              return CircularProgressIndicator();
                            }

                            if (state is AttendanceLoaded && state.list.isNotEmpty) {
                              final a = state.list[0];
                              return Text(a.status);
                            } else if (state is AttendanceLoaded && state.list.isEmpty){
                              return   SizedBox(
                                width: 200,
                                height: 48,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.how_to_reg),
                                  label: const Text("Request Attendance"),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    _showAttendanceDialog(context, userData);
                                  },
                                ),
                              );
                            }

                            if (state is AttendanceError) {
                              return Text(state.message);
                            }

                            return   SizedBox(
                              width: 200,
                              height: 48,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.how_to_reg),
                                label: const Text("Request Attendance"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  _showAttendanceDialog(context, userData);
                                },
                              ),
                            );
                          },
                        )

                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.video_call),
              label: const Text("Join Live Class"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/live',
                  arguments: ivsPlaybackUrl,
                );
              },
            ),

            const SizedBox(height: 12),


            // const SizedBox(height: 12),
            // OutlinedButton.icon(
            //   icon: const Icon(Icons.person_outline),
            //   label: const Text("View Profile"),
            //   style: OutlinedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(vertical: 14),
            //   ),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/profile');
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void _showAttendanceDialog(BuildContext context, Map<dynamic, dynamic> userData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Attendance Request"),
        content: const Text(
            "Are you sure you want to mark yourself as present?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              var date = getFormattedDate();
              var uid = FirebaseAuth.instance.currentUser?.uid;
              final attendance = Attendance(id: '', studentName: "${userData['first_name']} ${userData['last_name']}", date: date, status: 'Pending', studentId: '$uid');
              context.read<AttendanceBloc>().add(
                RequestAttendanceEvent(attendance),
              );

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Attendance requested")),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
