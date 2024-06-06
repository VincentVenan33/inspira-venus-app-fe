import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:venus/core/models/get_data/produk_get_data_dto.dart';
import 'package:venus/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:venus/core/networks/barang_get_data_dto_network.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:venus/core/networks/update_order_jual_detail_dto.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class EditItemDetailOrderJualViewModel extends BaseViewModel {
  EditItemDetailOrderJualViewModel({
    required BarangGetDataDTOService barangGetDataDTOApi,
    required SatuanBarangGetDataDTOService satuanBarangGetDataDTOApi,
    required OrderJualGetDataDTOService orderJualDetailGetDataDTOApi,
    required SetUpdateOrderJualDetailDTOService setUpdateOrderJualDetailDTOApi,
    required int nomor,
  })  : _barangGetDataDTOApi = barangGetDataDTOApi,
        _satuanBarangGetDataDTOApi = satuanBarangGetDataDTOApi,
        _orderJualDetailGetDataDTOApi = orderJualDetailGetDataDTOApi,
        _setUpdateOrderJualDetailDTOApi = setUpdateOrderJualDetailDTOApi,
        _nomor = nomor;

  final BarangGetDataDTOService _barangGetDataDTOApi;
  final SatuanBarangGetDataDTOService _satuanBarangGetDataDTOApi;
  final OrderJualGetDataDTOService _orderJualDetailGetDataDTOApi;
  final SetUpdateOrderJualDetailDTOService _setUpdateOrderJualDetailDTOApi;
  final int _nomor;

  final List<BarangGetDataContent> _barang = [];
  List<BarangGetDataContent> get barang => _barang;

  List<SatuanBarangGetDataContent> _satuanbarang = [];
  List<SatuanBarangGetDataContent> get satuanbarang => _satuanbarang;
  SatuanBarangGetDataContent? _selectedSatuanBarang;
  SatuanBarangGetDataContent? get selectedSatuanBarang => _selectedSatuanBarang;

  OrderJualGetDataContent? _orderjualdetail;
  OrderJualGetDataContent? get orderjualdetail => _orderjualdetail;

  final TextEditingController kodeController = TextEditingController();
  final TextEditingController nomorbarangController = TextEditingController();
  final TextEditingController nomorsatuanController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController satuanqtyController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController beratController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController satuanisiController = TextEditingController();
  final TextEditingController konversisatuanController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController diskon1Controller = TextEditingController();
  final TextEditingController diskon2Controller = TextEditingController();
  final TextEditingController diskon3Controller = TextEditingController();
  final TextEditingController directController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  int _qty = 0;
  int _netto = 0;
  int _disctotal = 0;
  int _discdirect = 0;
  int _diskon3 = 0;
  int _diskon2 = 0;
  int _diskon1 = 0;
  int _harga = 0;
  int _subtotal = 0;
  int jumlah = 0;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchSatuanBarang(_orderjualdetail?.intNomorMBarang ?? 0);
    await _fetchOrderJualDetail();
    await fetchBarang(reload: true);
    setBusy(false);
    hargaController.addListener(calculateDiscTotal);
    diskon1Controller.addListener(calculateDiscTotal);
    diskon2Controller.addListener(calculateDiscTotal);
    diskon3Controller.addListener(calculateDiscTotal);
    directController.addListener(calculateDiscTotal);
    hargaController.addListener(calculateNetto);
    totalController.addListener(calculateNetto);
    qtyController.addListener(calculateSubtotal);
    nettoController.addListener(calculateSubtotal);
  }

  void calculateDiscTotal() {
    _harga = int.tryParse(hargaController.text) ?? 0;
    double disc1Percentage = (double.tryParse(diskon1Controller.text) ?? 0) / 100;
    double disc2Percentage = (double.tryParse(diskon2Controller.text) ?? 0) / 100;
    double disc3Percentage = (double.tryParse(diskon3Controller.text) ?? 0) / 100;

    // Calculate discounts
    _diskon1 = (_harga * disc1Percentage).toInt();
    _diskon2 = ((_harga - _diskon1) * disc2Percentage).toInt();
    _diskon3 = ((_harga - _diskon1 - _diskon2) * disc3Percentage).toInt();

    _discdirect = int.tryParse(directController.text) ?? 0;
    debugPrint('diskon1 $_diskon1');
    debugPrint('diskon2 $_diskon2');
    debugPrint('diskon3 $_diskon3');
    // Calculate total
    _disctotal = _diskon1 + _diskon2 + _diskon3 + _discdirect;
    totalController.text = _disctotal.toString();
    notifyListeners();
  }

  void calculateNetto() {
    _harga = int.tryParse(hargaController.text) ?? 0;
    _disctotal = int.tryParse(totalController.text) ?? 0;
    _netto = _harga - _disctotal;
    nettoController.text = _netto.toString();
    notifyListeners();
  }

  void calculateSubtotal() {
    _qty = int.tryParse(qtyController.text) ?? 0;
    _netto = int.tryParse(nettoController.text) ?? 0;
    _subtotal = _qty * _netto;
    subtotalController.text = _subtotal.toString();
    notifyListeners();
  }

  BarangGetFilter barangcurrentFilter = BarangGetFilter(
    limit: 10,
    page: 1,
  );
  Future<void> fetchBarang({bool reload = false}) async {
    final search = BarangGetSearch(
      term: 'like',
      key: 'mbarang.vcNamaBeli',
      query: '',
    );
    if (reload) {
      _currentPage = 1;
      _barang.clear();
    }
    try {
      final newFilter = BarangGetFilter(
        limit: barangcurrentFilter.limit,
        page: _currentPage,
        intNomor: _nomor,
      );

      final response = await _barangGetDataDTOApi.getData(
        action: "getBarang",
        filters: newFilter,
        search: search,
        sort: "DESC",
        orderby: "mbarang.intNomor",
      );

      if (response.isRight) {
        final List<BarangGetDataContent> barangDataFromApi = response.right.data.data;
        _isLastPage = barangDataFromApi.length < barangcurrentFilter.limit;
        _barang.addAll(barangDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _fetchSatuanBarang(int nomorBarang) async {
    final filters = SatuanBarangGetFilter(
      query: nomorBarang,
    );
    debugPrint('nomorBarang $nomorBarang');
    final response = await _satuanBarangGetDataDTOApi.getData(
      action: "getSatuanBarang",
      filters: filters,
    );

    if (response.isRight) {
      _satuanbarang = response.right.data;
      notify();
    }
  }

  void setisLoadingMore(bool isLoadingMore) {
    _isLoadingMore = isLoadingMore;
    notify();
  }

  Future<void> _fetchOrderJualDetail() async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'tdorderjual.intNomorHeader',
      query: '',
    );

    final filters = OrderJualGetFilter(
      limit: 10,
      page: 1,
      intNomor: _nomor,
    );

    final response = await _orderJualDetailGetDataDTOApi.getData(
      action: "getOrderJualDetail",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _orderjualdetail = response.right.data.data[0];
      kodeController.text = _orderjualdetail?.vcKode ?? '';
      namaController.text = _orderjualdetail?.vcNamaJual ?? '';
      nomorbarangController.text = _orderjualdetail?.intNomorMBarang.toString() ?? '';
      nomorsatuanController.text = _orderjualdetail?.intNomorMSatuan1.toString() ?? '';
      qtyController.text = _orderjualdetail?.decJumlah1.toString() ?? '';
      satuanqtyController.text = _orderjualdetail?.satuan1.toString() ?? '';
      isiController.text = _orderjualdetail?.decJumlahUnit.toString() ?? '';
      satuanisiController.text = _orderjualdetail?.satuanUnit.toString() ?? '';
      hargaController.text = _orderjualdetail?.decHarga.toString() ?? '';
      diskon1Controller.text = _orderjualdetail?.decDisc1.toString() ?? '';
      diskon2Controller.text = _orderjualdetail?.decDisc2.toString() ?? '';
      diskon3Controller.text = _orderjualdetail?.decDisc3.toString() ?? '';
      nettoController.text = _orderjualdetail?.decNetto.toString() ?? '';
      subtotalController.text = _orderjualdetail?.decSubTotal.toString() ?? '';
      beratController.text = _orderjualdetail?.decBerat.toString() ?? '';

      notify();
    } else {}
  }

  void setselectedsatuanBarang(SatuanBarangGetDataContent? satuanbarang) {
    _selectedSatuanBarang = satuanbarang;
    notify();
  }

  Future<bool> updateOrderJualDetailModel({
    required int intNomorHeader,
    required int intNomorDetail,
    required int intNomorMBarang,
    required int intNomorMSatuan1,
    required int decJumlah1,
    required int decHarga,
    required int decJumlahUnit,
    required int decDisc1,
    required int decDisc2,
    required int decDisc3,
    required int decNetto,
    required int decSubTotal,
    required int decBerat,
  }) async {
    final response = await _setUpdateOrderJualDetailDTOApi.seUpdatetOrderJual(
      action: "updateOrderJualDetail",
      intNomorHeader: intNomorHeader,
      intNomorDetail: intNomorDetail,
      intNomorMBarang: intNomorMBarang,
      intNomorMSatuan1: intNomorMSatuan1,
      decJumlah1: decJumlah1,
      decHarga: decHarga,
      decJumlahUnit: decJumlahUnit,
      decDisc1: decDisc1,
      decNetto: decNetto,
      decDisc3: decDisc3,
      decDisc2: decDisc2,
      decSubTotal: decSubTotal,
      decBerat: decBerat,
      nomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
