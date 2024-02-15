import 'package:application_details_demo/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobAppBar extends StatelessWidget {
  const JobAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget barTitle(JobApplicationState state) {
      if (state.isLoading) {
        return const CircularProgressIndicator();
      }

      return AnimatedCrossFade(
        duration: const Duration(milliseconds: 0),
        crossFadeState: state.collapseProgress > 0.3
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: Text(
          state.application.jobAd,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'SourceSansPro',
          ),
        ),
        secondChild: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${state.application.firstName} ${state.application.lastName}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'SourceSansPro',
              ),
            ),
            Text(
              state.application.status ? 'A TRAITER' : 'TRAITE',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(10, 43, 146, 1),
                fontFamily: 'SourceSansPro',
              ),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<JobApplicationCubit, JobApplicationState>(
      builder: (_, state) {
        return AppBar(
          toolbarHeight: 70,
          backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
          leadingWidth: kToolbarHeight + 16,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            onPressed: () {},
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.more_vert_rounded, size: 16),
                onPressed: () {},
              ),
            ),
          ],
          centerTitle: true,
          title: barTitle(state),
        );
      },
    );
  }
}
