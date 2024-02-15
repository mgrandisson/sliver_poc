import 'package:application_details_demo/expandable_fab.dart';
import 'package:application_details_demo/job_app_bar.dart';
import 'package:application_details_demo/quick_actions.dart';
import 'package:application_details_demo/state.dart';
import 'package:application_details_demo/applications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JobApplicationCubit>(
          create: (_) => JobApplicationCubit()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: JobAppBar(),
      ),
      floatingActionButton:
          BlocBuilder<JobApplicationCubit, JobApplicationState>(
        builder: (_, state) {
          if (state.selectedTab == 0) {
            return ExpandableFab(
              context,
              fabOptions: [
                QuickAction(
                  isElevated: true,
                  icon: Icons.event_available,
                  iconColor: const Color.fromRGBO(10, 43, 146, 1),
                  bkgColor: const Color.fromRGBO(222, 227, 242, 1),
                ),
                QuickAction(
                  isElevated: true,
                  icon: Icons.message_outlined,
                  iconColor: const Color.fromRGBO(10, 43, 146, 1),
                  bkgColor: const Color.fromRGBO(222, 227, 242, 1),
                ),
                QuickAction(
                  isElevated: true,
                  icon: Icons.phone_outlined,
                  iconColor: const Color.fromRGBO(10, 43, 146, 1),
                  bkgColor: const Color.fromRGBO(222, 227, 242, 1),
                ),
                QuickAction(
                  isElevated: true,
                  icon: Icons.thumb_down_alt_outlined,
                  iconColor: const Color.fromRGBO(234, 6, 78, 1),
                  bkgColor: const Color.fromRGBO(249, 201, 216, 1),
                ),
                QuickAction(
                  isElevated: true,
                  icon: Icons.thumb_up_alt_outlined,
                  iconColor: const Color.fromRGBO(75, 148, 106, 1),
                  bkgColor: const Color.fromRGBO(209, 233, 219, 1),
                ),
              ],
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            );
          } else {
            return FloatingActionButton(
              onPressed: () {
                context.read<JobApplicationCubit>().fetchPage('0');
              },
              shape: const CircleBorder(),
              backgroundColor: const Color.fromRGBO(7, 208, 197, 1),
              elevation: 0,
              child: Icon(
                [
                  Icons.add,
                  Icons.edit,
                  Icons.send,
                  Icons.schedule,
                ][state.selectedTab],
                size: 30,
                color: Colors.white,
              ),
            );
          }
        },
      ),
      body: const ApplicationPageView(),
    );
  }
}
