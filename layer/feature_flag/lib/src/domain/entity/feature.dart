import 'package:flutter/material.dart';

enum Feature {
  contactUsHomeFab(
    key: 'contact_us_home_fab',
    title: 'Contact Us Home FAB',
    icon: Icons.contact_mail,
  ),
  languageSwitcher(
    key: 'language_switcher',
    title: 'Language Switcher',
    icon: Icons.language,
  ),
  mobileDetailVisibility(
    key: 'mobile_detail_visibility',
    title: 'Mobile Detail Visibility',
    icon: Icons.call,
  ),
  emailDetailVisibility(
    key: 'email_detail_visibility',
    title: 'Email Detail Visibility',
    icon: Icons.email,
  ),
  serviceDetail(
    key: 'service_detail',
    title: 'Service Detail',
    icon: Icons.details,
  );

  const Feature({required this.key, required this.title, required this.icon});

  factory Feature.getFeature(String key) {
    return Feature.values.firstWhere((feature) => feature.key == key);
  }

  final String key;
  final String title;
  final IconData icon;
}
