import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:venus/core/networks/approval_order_jual_dto_network.dart';
import 'package:venus/core/networks/delete_order_jual_dto.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class OrderJualViewModel extends BaseViewModel {
  OrderJualViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
    required SetDeleteOrderJualDTOService setDeleteOrderJualDTOApi,
    required SetApprovalOrderJualDTOService setApprovalOrderJualDTOApi,
  })  : _orderJualGetDataDTOApi = orderJualGetDataDTOApi,
        _setApprovalOrderJualDTOApi = setApprovalOrderJualDTOApi,
        _setDeleteOrderJualDTOApi = setDeleteOrderJualDTOApi;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;
  final SetApprovalOrderJualDTOService _setApprovalOrderJualDTOApi;
  final SetDeleteOrderJualDTOService _setDeleteOrderJualDTOApi;
  // final int _nomor;

  final List<OrderJualGetDataContent> _orderjual = [];
  List<OrderJualGetDataContent> get orderjual => _orderjual;
  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  String searchQuery = '';
  DateTime _selectedDateAwal = DateTime.now();
  DateTime get selectedDateAwal => _selectedDateAwal;
  DateTime _selectedDateAkhir = DateTime.now();
  DateTime get selectedDateAkhir => _selectedDateAkhir;

  void pickDateAwal(BuildContext context) async {
    // Add context parameter
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateAwal,
      firstDate: DateTime(2000), // Use a reasonable first date
      lastDate: DateTime.now(),
    );

    if (date != null) {
      _selectedDateAwal = date;
      notifyListeners();
      debugPrint('tanggal $_selectedDateAwal');
    }
  }

  void pickDateAkhir(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateAkhir,
      firstDate: DateTime(0000),
      lastDate: DateTime(9999),
    );

    if (date != null) {
      _selectedDateAkhir = date;
      notifyListeners();
      debugPrint('tanggal $_selectedDateAkhir');
    }
  }

  @override
  Future<void> initModel() async {
    setBusy(true);
    _selectedDateAwal = DateTime.now();
    _selectedDateAkhir = DateTime.now();
    await fetchOrderJual(reload: true);
    setBusy(false);
  }

  OrderJualGetFilter currentFilter = OrderJualGetFilter(
    limit: 10,
    page: 1,
    sort: 'DESC',
    orderby: 'thorderjual.intNomor',
  );
  Future<void> fetchOrderJual({bool reload = false}) async {
    final search = OrderJualGetSearch(
      term: 'equal',
      key: 'thorderjual.intStatus',
      query: "1",
    );
    if (reload) {
      _currentPage = 1;
      _orderjual.clear();
    }
    try {
      final newFilter = OrderJualGetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
        startdate: _selectedDateAwal.toIso8601String().substring(0, 10),
        enddate: _selectedDateAkhir.toIso8601String().substring(0, 10),
        sort: 'DESC',
        orderby: 'thorderjual.intNomor',
      );

      final response = await _orderJualGetDataDTOApi.getData(
        action: "getOrderJual",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<OrderJualGetDataContent> orderjualDataFromApi = response.right.data.data;
        _isLastPage = orderjualDataFromApi.length < currentFilter.limit;
        _orderjual.addAll(orderjualDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<bool> deleteOrderJualModel({
    required int intDeleteUserID,
    required int intNomor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setDeleteOrderJualDTOApi.setDeleteOrderJual(
      action: "softDeleteOrderJual",
      intDeleteUserID: json.decode(userDataJson!)['intNomor'],
      intNomor: intNomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> approvalOrderJualModel({
    required int intApproved,
    required String dtApproveTime,
    required int intNomor,
  }) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final response = await _setApprovalOrderJualDTOApi.setApprovalOrderJual(
      action: "updateOrderJual",
      intApproved: intApproved,
      dtApproveTime: formattedDate,
      intNomor: intNomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
