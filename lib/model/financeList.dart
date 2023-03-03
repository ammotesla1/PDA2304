import 'package:conduit/conduit.dart';
import 'package:dart_pr1/model/finance.dart';

class FinanceList extends ManagedObject<_FinanceList> implements _FinanceList {}

class _FinanceList {
  @primaryKey
  int? id;
  @Serialize(input: false, output: false)
  ManagedSet<Finance>? financeList;
}