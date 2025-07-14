import 'package:tracking/tracking.dart';

class _TrackingArea extends TrackingArea {
  const _TrackingArea() : super('home');
}

class HomeTrackingDelegate extends ScreenTrackingDelegate {
  HomeTrackingDelegate(TrackingReporter trackingReporter)
    : super(const _TrackingArea(), trackingReporter);

  void trackDrawerOpen() {
    trackEvent(
      Tracking(
        name: 'drawer_menu',
        action: const ViewAction(label: 'open'),
      ),
    );
  }

  void trackDrawerClose() {
    trackEvent(
      Tracking(
        name: 'drawer_menu',
        action: const ViewAction(label: 'close'),
      ),
    );
  }

  void trackDrawerItemSelection(String drawerItemName) {
    trackEvent(
      Tracking(
        name: 'drawer_menu',
        action: ClickAction(label: drawerItemName),
      ),
    );
  }

  void trackLoadingContentView() {
    trackEvent(ViewTracking(label: 'loading_content_view'));
  }

  void trackHomeContentView() {
    trackEvent(ViewTracking(label: 'home_content_view'));
  }

  void trackErrorContentView() {
    trackEvent(ViewTracking(label: 'error_content_view'));
  }

  void trackServicesSectionView() {
    trackEvent(ViewTracking(label: 'services_section'));
  }

  void trackClientSectionView() {
    trackEvent(ViewTracking(label: 'client_section'));
  }

  void trackTeamSectionView() {
    trackEvent(ViewTracking(label: 'team_section'));
  }

  void trackContactUsClick() {
    trackEvent(ClickTracking(label: 'contact_us'));
  }

  void trackJoinUsClick() {
    trackEvent(ClickTracking(label: 'join_us'));
  }

  void trackLogoClick({required bool isAuthenticatedToDevMode}) {
    trackEvent(
      ClickTracking(
        label: 'home_logo',
        value: isAuthenticatedToDevMode
            ? 'dev_menu_enabled'
            : 'dev_menu_disabled',
      ),
    );
  }
}
