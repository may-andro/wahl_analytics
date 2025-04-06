import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/careers_request_bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/careers_request_state.dart';

extension ContextExtension on BuildContext {
  CareersRequestBloc get bloc => read<CareersRequestBloc>();

  CareersRequestState get state => bloc.state;
}
