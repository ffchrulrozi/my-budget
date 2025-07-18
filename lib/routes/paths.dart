class Paths {
  static PathObject DASHBOARD = PathObject('dashboard', '/dashboard');
}

class PathObject {
  final String name;
  final String path;

  PathObject(this.name, this.path);
}
