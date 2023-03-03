import 'package:conduit/conduit.dart';
import 'package:dart_pr1/model/financeList.dart';

class Finance extends ManagedObject<_Finance> implements _Finance{}

class _Finance {
  @primaryKey
  int? id;

  String? financeName;

  String? financeDesc;

  String? financeCategory;

  String? financeDate;

  String? financeSum;

  @Relate(#financeList, isRequired: true, onDelete: DeleteRule.cascade)
  FinanceList? financeList;
}