abstract class DashboardState {}

class DashboardLoaded extends DashboardState{
  final int screenIndex;
  DashboardLoaded(this.screenIndex);
}