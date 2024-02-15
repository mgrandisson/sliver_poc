import 'package:application_details_demo/candidate.dart';
import 'package:application_details_demo/quick_actions.dart';
import 'package:application_details_demo/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationPageView extends StatelessWidget {
  const ApplicationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (index) {
        context.read<JobApplicationCubit>().fetchPage('$index');
      },
      children: context
          .read<JobApplicationCubit>()
          .state
          .applications
          .keys
          .map((id) => const StickyHeaderTest())
          .toList(),
    );
  }
}

class StickyHeaderTest extends StatefulWidget {
  const StickyHeaderTest({super.key});

  static const List<String> _tabs = <String>[
    'Commentaires',
    'Tab 2',
    'Tab 3',
    'Tab 4',
    'Tab 5',
    'Tab 6',
    'Tab 7',
    'Tab 8',
    'Tab 9',
    'Tab 10',
    'Tab 11',
    'Tab 12',
    'Tab 13',
    'Tab 14',
    'Tab 15',
    'Tab 16',
    'Tab 17',
    'Tab 18',
    'Tab 19',
    'Tab 20',
    'Tab 21',
    'Tab 22',
    'Tab 23',
    'Tab 24',
    'Tab 25',
    'Tab 26',
    'Tab 27',
    'Tab 28',
    'Tab 29',
    'Tab 30',
    'Tab 31',
    'Tab 32',
    'Tab 33',
    'Tab 34',
    'Tab 35',
    'Tab 36',
    'Tab 37',
    'Tab 38',
    'Tab 39',
    'Tab 40',
  ];

  @override
  State<StickyHeaderTest> createState() => _StickyHeaderTestState();
}

class _StickyHeaderTestState extends State<StickyHeaderTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<JobApplicationCubit>().onTabChange(_tabController.index);

    _tabController.animation?.addListener(() {
      if (_tabController.offset >= 0.5 && !_tabController.indexIsChanging) {
        context
            .read<JobApplicationCubit>()
            .onTabChange(_tabController.index + 1);
      }

      if (_tabController.offset <= -0.5 && !_tabController.indexIsChanging) {
        context
            .read<JobApplicationCubit>()
            .onTabChange(_tabController.index - 1);
      }

      if (_tabController.indexIsChanging) {
        context.read<JobApplicationCubit>().onTabChange(_tabController.index);
      }
    });

    return BlocBuilder<JobApplicationCubit, JobApplicationState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MyHeaderDelegate(),
                ),
                SliverAppBar(
                  snap: true,
                  floating: true,
                  backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
                  surfaceTintColor: const Color.fromRGBO(247, 248, 250, 1),
                  pinned: false,
                  toolbarHeight: kTextTabBarHeight + 15,
                  title: const QuickActionsBar(),
                  bottom: TabBar(
                    controller: _tabController,
                    physics: const ClampingScrollPhysics(),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorWeight: 8,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(7, 208, 197, 1),
                        ),
                      ),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SourceSansPro',
                      color: Color.fromRGBO(7, 208, 197, 1),
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SourceSansPro',
                      color: Color.fromRGBO(105, 112, 140, 1),
                    ),
                    tabs: const [
                      Text('Profil'),
                      Text('Commentaires'),
                      Text('Messages'),
                      Text('Entretiens'),
                    ],
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  const Text('Profil'),
                  ListView.separated(
                    itemCount: StickyHeaderTest._tabs.length,
                    separatorBuilder: (context, index) => const Divider(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return [
                        ...StickyHeaderTest._tabs.map((e) => Text(
                              e,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SourceSansPro',
                              ),
                            )),
                      ][index];
                    },
                  ),
                  const Text('Messages'),
                  const Text('Entretiens'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
