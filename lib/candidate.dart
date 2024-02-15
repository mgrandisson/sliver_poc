import 'package:application_details_demo/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Candidate extends StatelessWidget {
  const Candidate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobApplicationCubit, JobApplicationState>(
      builder: (_, state) {
        return Container(
          color: const Color.fromRGBO(247, 248, 250, 1),
          padding: const EdgeInsets.all(16),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 0),
            opacity: 1 - state.collapseProgress,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 0),
              offset: Offset(0, state.collapseProgress * -0.5),
              child: AnimatedScale(
                  duration: const Duration(milliseconds: 0),
                  scale: 1 - state.collapseProgress,
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Wrap(
                          spacing: 8,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color.fromRGBO(7, 208, 197, 1),
                                  width: 1,
                                ),
                              ),
                              width: 68,
                              height: 68,
                              child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  '${state.application.firstName} ${state.application.lastName}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Aller',
                                  ),
                                ),
                                Text(
                                  state.application.origin,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: 'SourceSansPro',
                                  ),
                                ),
                                Container(
                                  color: const Color.fromRGBO(222, 227, 242, 1),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text(
                                    state.application.status
                                        ? 'A TRAITER'
                                        : 'TRAITE',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(10, 43, 146, 1),
                                      fontFamily: 'SourceSansPro',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
            ),
          ),
        );
      },
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  MyHeaderDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress = shrinkOffset / maxExtent;
    context.read<JobApplicationCubit>().updateCollapseProgress(progress);

    return const Candidate();
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
