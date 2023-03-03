import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_pr1/model/finance.dart';
import 'package:dart_pr1/model/financeList.dart';
import 'package:dart_pr1/model/model_response.dart';
import 'package:dart_pr1/utils/app_response.dart';
import 'package:dart_pr1/utils/app_utils.dart';

class AppFinanceController extends ResourceController {
  AppFinanceController(this.managedContext);

  final ManagedContext managedContext;

  @Operation.post()
  Future<Response> createFinance(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() Finance finance) async {
      try {
        final id = AppUtils.getIdFromHeader(header);
        final financeList = await managedContext.fetchObjectWithID<FinanceList>(id);

        if(financeList == null) {
          final qCreateFinanceList = Query<FinanceList>(managedContext)..values.id = id;
          await qCreateFinanceList.insert();
        }

        final qCreateFinance = Query<Finance>(managedContext)
        ..values.financeName = finance.financeName
        ..values.financeDesc = finance.financeDesc
        ..values.financeCategory = finance.financeCategory
        ..values.financeDate = finance.financeDate
        ..values.financeSum = finance.financeSum
        ..values.financeList!.id = id;

        await qCreateFinance.insert();

        return AppResponse.ok(message: 'Успешное создание финанса!');
      } catch (e) {
        return AppResponse.serverError(e, message: 'Ошибка создания финанса!');
      }
    }

  @Operation.get("id")
  Future<Response> getOneFinance(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int id,
  ) async {
    try {
      final currentFinanceListId = AppUtils.getIdFromHeader(header);
      final finance = await managedContext.fetchObjectWithID<Finance>(id);
      if(finance == null) {
        return AppResponse.ok(message: "Финанс не найден!");
      }
      if(finance.financeList!.id != currentFinanceListId) {
        return AppResponse.ok(message: "Нет доступа к финансу!");
      }
      finance.backing.removeProperty("financeList");

      return AppResponse.ok(
        body: finance.backing.contents, message: "Успешное создание финанса!"
      );
    } catch (e) {
      return AppResponse.serverError(e, message: "Ошибка создания финанса!");
    }
  }

  @Operation.get()
  Future<Response> getPagedFinances(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.query("page") int page,
  ) async {
    if(page.isNaN || page < 1 || page == 1) page = 0;
    if(page > 1) page = (page - 1) * 3;
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qCreateFinance = Query<Finance>(managedContext)
      ..where((x) => x.financeList!.id).equalTo(id)
      ..offset = page
      ..fetchLimit = 3;

      final List<Finance> listfinance = await qCreateFinance.fetch();

      if (listfinance.isEmpty) {
        return Response.notFound(
          body: ModelResponse(data: [], message: "Нет ни одной записи!")
        );
      }

      return Response.ok(listfinance);
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

  @Operation.put('id')
  Future<Response> updateFinance(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int id,
    @Bind.body() Finance bodyfinance
  ) async {
      try {
        final currentFinanceListId = AppUtils.getIdFromHeader(header);
        final finance = await managedContext.fetchObjectWithID<Finance>(id);
        if(finance == null) {
          return AppResponse.ok(message: "Финанс не найден!");
        }
        if(finance.financeList!.id != currentFinanceListId) {
          return AppResponse.ok(message: "Нет доступа к финансу!");
        }

        final qUpdateFinance = Query<Finance>(managedContext)
        ..where((x) => x.id).equalTo(id)
        ..values.financeName = bodyfinance.financeName
        ..values.financeDesc = bodyfinance.financeDesc
        ..values.financeCategory = bodyfinance.financeCategory
        ..values.financeDate = bodyfinance.financeDate
        ..values.financeSum = bodyfinance.financeSum;

        await qUpdateFinance.update();

        return AppResponse.ok(message: "Финанс успешно обновлен!");
      } catch (e) {
        return AppResponse.serverError(e);
      }
    }

  @Operation.delete("id")
  Future<Response> deleteFinance(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int id,
  ) async {
    try {
      final currentFinanceListId = AppUtils.getIdFromHeader(header);
      final finance = await managedContext.fetchObjectWithID<Finance>(id);
      if(finance == null) {
        return AppResponse.ok(message: "Финанс не найден!");
      }
      if(finance.financeList!.id != currentFinanceListId) {
        return AppResponse.ok(message: "Нет доступа к финансу!");
      }

      final qDeleteFinance = Query<Finance>(managedContext)
      ..where((x) => x.id).equalTo(id);
      await qDeleteFinance.delete();
      return AppResponse.ok(message: "Финанс успешно удалён!");
    } catch (e) {
      return AppResponse.serverError(e, message: "Ошибка удаления финанса!");
    }
  }
}