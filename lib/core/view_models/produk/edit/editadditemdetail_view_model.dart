import 'package:flutter/material.dart';
import 'package:venus/core/models/get_data/get_data_dto.dart';
import 'package:venus/core/models/get_data/produk_get_data_dto.dart';
import 'package:venus/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/models/set_data/create_order_jual_dto.dart';
import 'package:venus/core/networks/barang_get_data_dto_network.dart';
import 'package:venus/core/networks/create_order_jual_detail_dto.dart';
import 'package:venus/core/networks/get_data_dto_network.dart';
import 'package:venus/core/networks/satuan_barang_get_data_dto_network.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class EditAddItemDetailOrderJualViewModel extends BaseViewModel {
  EditAddItemDetailOrderJualViewModel({
    required GetDataDTOService getDataDTOApi,
    required BarangGetDataDTOService barangGetDataDTOApi,
    required SatuanBarangGetDataDTOService satuanBarangGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required SetOrderJualDetailDTOService setOrderJualDetailDTOApi,
    required int nomor,
  })  : _getDataDTOApi = getDataDTOApi,
        _barangGetDataDTOApi = barangGetDataDTOApi,
        _satuanBarangGetDataDTOApi = satuanBarangGetDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _setOrderJualDetailDTOApi = setOrderJualDetailDTOApi,
        _nomor = nomor;

  final GetDataDTOService _getDataDTOApi;
  final BarangGetDataDTOService _barangGetDataDTOApi;
  final SatuanBarangGetDataDTOService _satuanBarangGetDataDTOApi;
  final SharedPreferencesService _sharedPreferencesService;
  final SetOrderJualDetailDTOService _setOrderJualDetailDTOApi;
  final int _nomor;

  final List<BarangGetDataContent> _barang = [];
  List<BarangGetDataContent> get barang => _barang;

  List<SatuanBarangGetDataContent> _satuanbarang = [];
  List<SatuanBarangGetDataContent> get satuanbarang => _satuanbarang;
  SatuanBarangGetDataContent? _selectedSatuanBarang;
  SatuanBarangGetDataContent? get selectedSatuanBarang => _selectedSatuanBarang;

  final List<GetDataContent> _customer = [];
  List<GetDataContent> get customer => _customer;
  GetDataContent? _selectedCustomer;
  GetDataContent? get selectedCustomer => _selectedCustomer;

  List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  String searchQuery = '';

  GetFilter currentFiltercustomer = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "mhrelasi.nama",
  );

  @override
  Future<void> initModel() async {
    setBusy(true);
    await fetchBarang(reload: true);
    await _fetchSatuanBarang(_nomor);
    setBusy(false);
  }

  BarangGetFilter currentFilter = BarangGetFilter(
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
        limit: currentFilter.limit,
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
        _isLastPage = barangDataFromApi.length < currentFilter.limit;
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

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchCustomer();
    setisLoadingMore(false);
  }

  Future<void> fetchCustomer({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mhrelasi.nama',
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _customer.clear();
    } else {
      // Add this else part
      _isLoadingMore = true; // Set loading before fetching
    }
    try {
      final newFilter = GetFilter(
        limit: currentFiltercustomer.limit,
        page: _currentPage,
        sort: currentFiltercustomer.sort,
        orderby: currentFiltercustomer.orderby,
      );

      final response = await _getDataDTOApi.getData(
        action: "getCustomer",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> customerDataFromApi = response.right.data.data;
        _isLastPage = customerDataFromApi.length < currentFiltercustomer.limit;

        _customer.addAll(customerDataFromApi);
        if (_isLastPage == false) {
          _currentPage++;
        }

        notify();
        setBusy(false);
        _isLoadingMore = false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      setBusy(false);
      _isLoadingMore = false;
    }
  }

  void setselectedsatuanBarang(SatuanBarangGetDataContent? satuanbarang) {
    _selectedSatuanBarang = satuanbarang;
    notify();
  }

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    notify();
  }

  Future<bool> addOrderJualDetailModel({
    required String formatcode,
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
    required String dtTanggal,
    required int decBerat,
  }) async {
    final response = await _setOrderJualDetailDTOApi.setOrderJualDetail(
      action: "addOrderJualDetail",
      formatcode: formatcode,
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
      dtTanggal: dtTanggal,
      decBerat: decBerat,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> addItemtoList(CreateOrderJualDetailRequest detailItemParam) async {
    final ListDetailItem? detailItem = await _sharedPreferencesService.get(
      SharedPrefKeys.detailItemOrderJual,
    );
    _detailItems = detailItem?.items ?? [];
    _detailItems.add(detailItemParam);
    _sharedPreferencesService.set(
      SharedPrefKeys.detailItemOrderJual,
      ListDetailItem(
        items: _detailItems,
      ),
    );
    return true;
  }
}
