import 'package:drift/drift.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/tables/categories.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);
  
  Future<List<Category>> getByType(int typeId) {
    return (select(categories)..where((c) => c.typeId.equals(typeId))).get();
  }
}
