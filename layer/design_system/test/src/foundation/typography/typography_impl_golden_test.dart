import 'package:flutter/material.dart';

import '../../../util/alchemist_utils.dart';

void main() {
  const text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
      ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      ' aute irure dolor in reprehenderit in voluptate velit esse cillum dolore'
      ' eu fugiat nulla pariatur.';

  groupGoldenForBrightnessAndDS(
    'Typography',
    (dsTheme) => [
      TestCase(
        'Display Large',
        Text(
          text,
          style: dsTheme.typography.displayLarge.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Display Medium',
        Text(
          text,
          style: dsTheme.typography.displayMedium.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Display Small',
        Text(
          text,
          style: dsTheme.typography.displaySmall.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Headline Large',
        Text(
          text,
          style: dsTheme.typography.headlineLarge.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Headline Medium',
        Text(
          text,
          style: dsTheme.typography.headlineMedium.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Headline Small',
        Text(
          text,
          style: dsTheme.typography.headlineSmall.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Title Large',
        Text(
          text,
          style: dsTheme.typography.titleLarge.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Title Medium',
        Text(
          text,
          style: dsTheme.typography.titleMedium.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Title Small',
        Text(
          text,
          style: dsTheme.typography.titleSmall.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Body Large',
        Text(
          text,
          style: dsTheme.typography.bodyLarge.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Body Medium',
        Text(
          text,
          style: dsTheme.typography.bodyMedium.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Body Small',
        Text(
          text,
          style: dsTheme.typography.bodySmall.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Label Large',
        Text(
          text,
          style: dsTheme.typography.labelLarge.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Label Medium',
        Text(
          text,
          style: dsTheme.typography.labelMedium.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
      TestCase(
        'Label Small',
        Text(
          text,
          style: dsTheme.typography.labelSmall.textStyle.copyWith(
            color: dsTheme.colorPalette.neutral.grey9.color,
          ),
        ),
      ),
    ],
    label: 'text',
  );
}
