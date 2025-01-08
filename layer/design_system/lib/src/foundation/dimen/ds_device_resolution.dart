enum DSDeviceResolution {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == mobile;

  bool get isTablet => this == tablet;

  bool get isDesktop => this == desktop;
}

enum DSDeviceWidthResolution { xs, s, m, l, xl }
