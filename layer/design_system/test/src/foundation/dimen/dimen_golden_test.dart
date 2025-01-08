import 'package:flutter/material.dart';

import '../../../util/alchemist_utils.dart';

void main() {
  groupGoldenForBrightnessAndDS(
    'dimen',
    (dsTheme) => [
      TestCase(
        'Elevation None',
        Card(
          elevation: dsTheme.dimen.elevationNone.value,
          color: dsTheme.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
      TestCase(
        'Elevation Level1',
        Card(
          elevation: dsTheme.dimen.elevationLevel1.value,
          color: dsTheme.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
      TestCase(
        'Elevation Level2',
        Card(
          elevation: dsTheme.dimen.elevationLevel2.value,
          color: dsTheme.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
      TestCase(
        'Elevation Level3',
        Card(
          elevation: dsTheme.dimen.elevationLevel3.value,
          color: dsTheme.colorPalette.brand.primary.color,
          child: const SizedBox(height: 120, width: 120),
        ),
      ),
    ],
    label: 'elevation',
  );
}
