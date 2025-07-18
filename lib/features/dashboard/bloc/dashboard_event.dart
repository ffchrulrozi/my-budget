abstract class DashboardEvent {}

class ChangeScreen extends DashboardEvent {
  final int screenIndex;
  ChangeScreen(this.screenIndex);
}
