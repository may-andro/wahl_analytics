import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/home/presentation/tracking/drawer_tracking_action.dart';

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
        action: const DrawerTrackingAction(status: 'open'),
      ),
    );
  }

  void trackDrawerClose() {
    trackEvent(
      Tracking(
        name: 'drawer_menu',
        action: const DrawerTrackingAction(status: 'close'),
      ),
    );
  }

  void trackDrawerItemSelection(String drawerItemName) {
    trackEvent(
      Tracking(
        name: 'drawer_menu',
        action: ClickAction(label: 'drawer_item', value: drawerItemName),
      ),
    );
  }

  void trackLoadingContentView() {
    trackEvent(ViewTracking(name: 'loading_content_view'));
  }

  void trackHomeContentView() {
    trackEvent(ViewTracking(name: 'home_content_view'));
  }

  void trackErrorContentView() {
    trackEvent(ViewTracking(name: 'error_content_view'));
  }

  void trackServicesSectionView() {
    trackEvent(ViewTracking(name: 'services_section'));
  }

  void trackClientSectionView() {
    trackEvent(ViewTracking(name: 'client_section'));
  }

  void trackTeamSectionView() {
    trackEvent(ViewTracking(name: 'team_section'));
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
