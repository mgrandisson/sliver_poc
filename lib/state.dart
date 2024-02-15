import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobApplicationCubit extends Cubit<JobApplicationState> {
  JobApplicationCubit() : super(JobApplicationState());

  PageController pageController = PageController();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final JobApplicationV2 application;
    final List<JobApplicationCustomFieldV2> customFields;

    if (state.cacheApplications.containsKey('0')) {
      application = state.cacheApplications['0']!;
      customFields = state.customFields;
    } else {
      final result = await Future.wait([
        _getJobApplicationV2('0'),
        _getJobApplicationCustomFieldsV2('0'),
      ]);

      application = result[0] as JobApplicationV2;
      customFields = result[1] as List<JobApplicationCustomFieldV2>;
    }

    _addApplicationToCache(application);

    emit(state.copyWith(
      application: application,
      customFields: customFields,
      isLoading: false,
    ));
  }

  Future<void> fetchPage(String id) async {
    emit(state.copyWith(isLoading: true));
    final JobApplicationV2 application;
    final List<JobApplicationCustomFieldV2> customFields;

    if (state.cacheApplications.containsKey(id)) {
      application = state.cacheApplications[id]!;
      customFields = state.customFields;
    } else {
      final result = await Future.wait([
        _getJobApplicationV2(id),
        _getJobApplicationCustomFieldsV2(id),
      ]);

      application = result[0] as JobApplicationV2;
      customFields = result[1] as List<JobApplicationCustomFieldV2>;
    }

    _addApplicationToCache(application);
    emit(state.copyWith(
      application: application,
      customFields: customFields,
      isLoading: false,
    ));
  }

  void updateCollapseProgress(double progress) {
    emit(state.copyWith(collapseProgress: progress));
  }

  Future<JobApplicationV2> _getJobApplicationV2(String id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return state.applications[id] ?? const JobApplicationV2.initial();
    });
  }

  Future<List<JobApplicationCustomFieldV2>> _getJobApplicationCustomFieldsV2(
      String id) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        JobApplicationCustomFieldV2(
          question: 'Etes-vous mobile ?',
          name: 'Mobilité géographique',
          data: 'Paris et sa région',
        ),
        JobApplicationCustomFieldV2(
          question: 'Quel(s) sport(s) pratiquez vous ?',
          name: 'Sport',
          data: 'Judo',
        ),
      ],
    );
  }

  void _addApplicationToCache(JobApplicationV2 application) {
    Map<String, JobApplicationV2> cache = Map.from(state.cacheApplications);

    cache[application.id] = application;

    emit(state.copyWith(cacheApplications: cache));
  }

  void onTabChange(int index) {
    emit(state.copyWith(selectedTab: index));
  }
}

class JobApplicationState {
  final JobApplicationV2 application;
  final Map<String, JobApplicationV2> cacheApplications;
  final List<JobApplicationCustomFieldV2> customFields;
  final int selectedTab;
  final double collapseProgress;
  final bool isLoading;

  JobApplicationState({
    this.application = const JobApplicationV2.initial(),
    this.cacheApplications = const {},
    this.customFields = const [],
    this.selectedTab = 0,
    this.collapseProgress = 0.0,
    this.isLoading = false,
  });

  JobApplicationState copyWith({
    JobApplicationV2? application,
    Map<String, JobApplicationV2>? cacheApplications,
    List<JobApplicationCustomFieldV2>? customFields,
    int? selectedTab,
    double? collapseProgress,
    bool? isLoading,
  }) {
    return JobApplicationState(
      application: application ?? this.application,
      cacheApplications: cacheApplications ?? this.cacheApplications,
      customFields: customFields ?? this.customFields,
      selectedTab: selectedTab ?? this.selectedTab,
      collapseProgress: collapseProgress ?? this.collapseProgress,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, JobApplicationV2> get applications => {
        '0': JobApplicationV2(
          id: '0',
          firstName: 'Etienne',
          lastName: 'Chevalier',
          origin: 'Site carrière • 01/01/2022',
          jobAd: 'Conseiller vente immobilier (H/F)',
          status: true,
        ),
        '1': JobApplicationV2(
          id: '1',
          firstName: 'Jane',
          lastName: 'Doe',
          origin: 'Indeed',
          jobAd: 'Junior Flutter Developer',
          status: false,
        ),
        '2': JobApplicationV2(
          id: '2',
          firstName: 'Alex',
          lastName: 'Smith',
          origin: 'LinkedIn',
          jobAd: 'Data Scientist',
          status: true,
        ),
      };
}

class JobApplicationV2 {
  final String id;
  final String firstName;
  final String lastName;
  final String origin;
  final String jobAd;
  final bool status;

  JobApplicationV2({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.origin,
    required this.jobAd,
    required this.status,
  });

  const JobApplicationV2.initial({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.origin = '',
    this.jobAd = '',
    this.status = false,
  });
}

class JobApplicationCustomFieldV2 {
  final String question;
  final String name;
  final String data;

  JobApplicationCustomFieldV2(
      {required this.question, required this.name, required this.data});

  const JobApplicationCustomFieldV2.initial({
    this.question = '',
    this.name = '',
    this.data = '',
  });
}
