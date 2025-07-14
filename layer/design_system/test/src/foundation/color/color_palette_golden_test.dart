import 'package:flutter/material.dart';

import '../../../util/alchemist_utils.dart';

void main() {
  groupGoldenForBrightnessAndDS(
    'Color palette',
    (dsTheme) => [
      TestCase(
        'Primary',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.brand.primary.color),
      ),
      TestCase(
        'OnPrimary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.onPrimary.color,
        ),
      ),
      TestCase(
        'Primary Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.primaryContainer.color,
        ),
      ),
      TestCase(
        'On Primary Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.onPrimaryContainer.color,
        ),
      ),
      TestCase(
        'Secondary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.secondary.color,
        ),
      ),
      TestCase(
        'On Secondary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.onSecondary.color,
        ),
      ),
      TestCase(
        'Secondary Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.secondaryContainer.color,
        ),
      ),
      TestCase(
        'On Secondary Container',
        CircleAvatar(
          backgroundColor:
              dsTheme.colorPalette.brand.onSecondaryContainer.color,
        ),
      ),
      TestCase(
        'Tertiary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.tertiary.color,
        ),
      ),
      TestCase(
        'On Tertiary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.onTertiary.color,
        ),
      ),
      TestCase(
        'Tertiary Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.tertiaryContainer.color,
        ),
      ),
      TestCase(
        'On Tertiary Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.brand.onTertiaryContainer.color,
        ),
      ),
    ],
    label: 'brand scheme',
  );

  groupGoldenForBrightnessAndDS(
    'Color palette',
    (dsTheme) => [
      TestCase(
        'Info',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.semantic.info.color),
      ),
      TestCase(
        'On Info',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onInfo.color,
        ),
      ),
      TestCase(
        'Info Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.infoContainer.color,
        ),
      ),
      TestCase(
        'On Info Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onInfoContainer.color,
        ),
      ),
      TestCase(
        'Success',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.success.color,
        ),
      ),
      TestCase(
        'On Success',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onSuccess.color,
        ),
      ),
      TestCase(
        'Success Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.successContainer.color,
        ),
      ),
      TestCase(
        'On Success Container',
        CircleAvatar(
          backgroundColor:
              dsTheme.colorPalette.semantic.onSuccessContainer.color,
        ),
      ),
      TestCase(
        'Warning',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.warning.color,
        ),
      ),
      TestCase(
        'On Warning',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onWarning.color,
        ),
      ),
      TestCase(
        'Warning Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.warningContainer.color,
        ),
      ),
      TestCase(
        'On Warning Container',
        CircleAvatar(
          backgroundColor:
              dsTheme.colorPalette.semantic.onWarningContainer.color,
        ),
      ),
      TestCase(
        'Error',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.error.color,
        ),
      ),
      TestCase(
        'On Error',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onError.color,
        ),
      ),
      TestCase(
        'Error Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.errorContainer.color,
        ),
      ),
      TestCase(
        'On Error Container',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.semantic.onErrorContainer.color,
        ),
      ),
    ],
    label: 'semantic scheme',
  );

  groupGoldenForBrightnessAndDS(
    'Color palette',
    (dsTheme) => [
      TestCase(
        'White',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.white.color),
      ),
      TestCase(
        'Black',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.black.color),
      ),
      TestCase(
        'Grey1',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey1.color),
      ),
      TestCase(
        'Grey2',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey2.color),
      ),
      TestCase(
        'Grey3',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey3.color),
      ),
      TestCase(
        'Grey4',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey4.color),
      ),
      TestCase(
        'Grey5',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey5.color),
      ),
      TestCase(
        'Grey6',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey6.color),
      ),
      TestCase(
        'Grey7',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey7.color),
      ),
      TestCase(
        'Grey8',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey8.color),
      ),
      TestCase(
        'Grey9',
        CircleAvatar(backgroundColor: dsTheme.colorPalette.neutral.grey9.color),
      ),
      TestCase(
        'Grey10',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.neutral.grey10.color,
        ),
      ),
    ],
    label: 'neutral scheme',
  );

  groupGoldenForBrightnessAndDS(
    'Color palette',
    (dsTheme) => [
      TestCase(
        'Primary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.primary.color,
        ),
      ),
      TestCase(
        'On Primary',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.onPrimary.color,
        ),
      ),
      TestCase(
        'Surface',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.surface.color,
        ),
      ),
      TestCase(
        'On Surface',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.onSurface.color,
        ),
      ),
      TestCase(
        'Disabled',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.disabled.color,
        ),
      ),
      TestCase(
        'On Disabled',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.onDisabled.color,
        ),
      ),
      TestCase(
        'Surface Variant',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.surfaceVariant.color,
        ),
      ),
      TestCase(
        'On Surface Variant',
        CircleAvatar(
          backgroundColor:
              dsTheme.colorPalette.background.onSurfaceVariant.color,
        ),
      ),
      TestCase(
        'Inverse Surface',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.inverseSurface.color,
        ),
      ),
      TestCase(
        'On Inverse Surface',
        CircleAvatar(
          backgroundColor:
              dsTheme.colorPalette.background.onInverseSurface.color,
        ),
      ),
      TestCase(
        'Shadow',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.shadow.color,
        ),
      ),
      TestCase(
        'Scrim',
        CircleAvatar(
          backgroundColor: dsTheme.colorPalette.background.scrim.color,
        ),
      ),
    ],
    label: 'background scheme',
  );
}
