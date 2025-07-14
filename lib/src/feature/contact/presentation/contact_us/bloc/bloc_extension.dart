import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/contact_us_bloc.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/contact_us_state.dart';

extension ContextExtension on BuildContext {
  ContactUsBloc get bloc => read<ContactUsBloc>();

  ContactUsState get state => bloc.state;
}
