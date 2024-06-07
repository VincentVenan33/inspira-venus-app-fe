import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/core/models/get_data/area_get_data_dto.dart';
import 'package:venus/core/models/get_data/get_data_dto.dart';
import 'package:venus/core/models/get_data/jenis_penjualan_get_data_dto.dart';
import 'package:venus/core/models/get_data/valuta_get_data_dto.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/models/set_data/create_order_jual_dto.dart';
import 'package:venus/core/networks/area_get_data_dto_network.dart';
import 'package:venus/core/networks/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/networks/get_data_dto_network.dart';
import 'package:venus/core/networks/jenis_penjualan_get_data_dto_network.dart';
import 'package:venus/core/networks/valuta_get_data_dto_network.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class AddOrderJualViewModel extends BaseViewModel {
  AddOrderJualViewModel({
    required GetDataDTOService getDataDTOApi,
    required JenisPenjualanGetDataDTOService jenisPenjualanGetDataDTOApi,
    required AreaGetDataDTOService areaGetDataDTOApi,
    required ValutaGetDataDTOService valutaGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required SetOrderJualDetailBonusDTOService setOrderJualDetailBonusDTOApi,
  })  : _getDataDTOApi = getDataDTOApi,
        _jenisPenjualanGetDataDTOApi = jenisPenjualanGetDataDTOApi,
        _areaGetDataDTOApi = areaGetDataDTOApi,
        _valutaGetDataDTOApi = valutaGetDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _setOrderJualDetailBonusDTOApi = setOrderJualDetailBonusDTOApi;

  final GetDataDTOService _getDataDTOApi;
  final JenisPenjualanGetDataDTOService _jenisPenjualanGetDataDTOApi;
  final AreaGetDataDTOService _areaGetDataDTOApi;
  final ValutaGetDataDTOService _valutaGetDataDTOApi;
  final SharedPreferencesService _sharedPreferencesService;
  final SetOrderJualDetailBonusDTOService _setOrderJualDetailBonusDTOApi;

  final TextEditingController ppnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  List<CreateOrderJualDetailRequest> _detailItems = [];
  List<CreateOrderJualDetailRequest> get detailItems => _detailItems;

  final List<GetDataContent> _customer = [];
  List<GetDataContent> get customer => _customer;
  GetDataContent? _selectedCustomer;
  GetDataContent? get selectedCustomer => _selectedCustomer;

  final List<GetDataContent> _sales = [];
  List<GetDataContent> get sales => _sales;
  GetDataContent? _selectedSales;
  GetDataContent? get selectedSales => _selectedSales;

  final List<GetDataContent> _gudang = [];
  List<GetDataContent> get gudang => _gudang;
  GetDataContent? _selectedGudang;
  GetDataContent? get selectedGudang => _selectedGudang;

  List<ValutaGetDataContent> _valuta = [];
  List<ValutaGetDataContent> get valuta => _valuta;
  ValutaGetDataContent? _selectedValuta;
  ValutaGetDataContent? get selectedValuta => _selectedValuta;

  final List<AreaGetDataContent> _area = [];
  List<AreaGetDataContent> get area => _area;
  AreaGetDataContent? _selectedArea;
  AreaGetDataContent? get selectedArea => _selectedArea;

  List<JenisPenjualanGetDataContent> _jenispenjualan = [];
  List<JenisPenjualanGetDataContent> get jenispenjualan => _jenispenjualan;
  JenisPenjualanGetDataContent? _selectedJenisPenjualan;
  JenisPenjualanGetDataContent? get selectedJenisPenjualan => _selectedJenisPenjualan;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  // ignore: unused_field
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  void setLoading(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _isLoadingMore = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  String searchQuery = '';

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  GetFilter currentFilter = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "mcustomer.vcNama",
  );

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchDetailItem();
    _fetchJenisPenjualan();
    await _fetchValuta();
    await _fecthUser();
    setBusy(false);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchCustomer();
    await fetchGudang();
    await fetchSales();
    await fetchArea();
    setisLoadingMore(false);
  }

  Future<void> fetchCustomer({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mcustomer.vcNama',
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
        limit: currentFilter.limit,
        page: _currentPage,
        sort: currentFilter.sort,
        orderby: currentFilter.orderby,
      );

      final response = await _getDataDTOApi.getData(
        action: "getCustomer",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> customerDataFromApi = response.right.data.data;
        _isLastPage = customerDataFromApi.length < currentFilter.limit;

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

  GetFilter salesCurrentFilter = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "msales.vcNama",
  );

  Future<void> fetchSales({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'msales.vcNama',
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _sales.clear();
    } else {
      // Add this else part
      _isLoadingMore = true; // Set loading before fetching
    }
    try {
      final newFilter = GetFilter(
        limit: salesCurrentFilter.limit,
        page: _currentPage,
        sort: salesCurrentFilter.sort,
        orderby: salesCurrentFilter.orderby,
      );

      final response = await _getDataDTOApi.getData(
        action: "getSales",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> salesDataFromApi = response.right.data.data;
        _isLastPage = salesDataFromApi.length < salesCurrentFilter.limit;

        _sales.addAll(salesDataFromApi);
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

  GetFilter gudangCurrentFilter = GetFilter(
    limit: 20,
    sort: "ASC",
    orderby: "mgudang.vcNama",
  );

  Future<void> fetchGudang({bool reload = false}) async {
    final search = GetSearch(
      term: 'like',
      key: 'mgudang.vcNama',
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _gudang.clear();
    } else {
      _isLoadingMore = true; // Set loading before fetching
    }
    try {
      final newFilter = GetFilter(
        limit: gudangCurrentFilter.limit,
        page: _currentPage,
        sort: gudangCurrentFilter.sort,
        orderby: gudangCurrentFilter.orderby,
      );

      final response = await _getDataDTOApi.getData(
        action: "getGudang",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<GetDataContent> gudangDataFromApi = response.right.data.data;
        _isLastPage = gudangDataFromApi.length < gudangCurrentFilter.limit;

        _gudang.addAll(gudangDataFromApi);
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

  AreaGetFilter areaCurrentFilter = AreaGetFilter(
    limit: 10,
    sort: "ASC",
    orderby: "marea.vcNama",
  );

  Future<void> fetchArea({bool reload = false}) async {
    final search = AreaGetSearch(
      term: 'like',
      key: 'marea.vcNama',
      query: searchQuery,
    );
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _area.clear();
    } else {
      // Add this else part
      _isLoadingMore = true; // Set loading before fetching
    }
    try {
      final newFilter = AreaGetFilter(
        limit: areaCurrentFilter.limit,
        page: _currentPage,
        sort: areaCurrentFilter.sort,
        orderby: areaCurrentFilter.orderby,
      );

      final response = await _areaGetDataDTOApi.getData(
        action: "getArea",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        final List<AreaGetDataContent> areaDataFromApi = response.right.data.data;
        _isLastPage = areaDataFromApi.length < areaCurrentFilter.limit;

        _area.addAll(areaDataFromApi);
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

  Future<void> _fetchJenisPenjualan() async {
    final filters = JenisPenjualanGetFilter(
      limit: 10,
    );

    final search = JenisPenjualanGetSearch(
      term: 'like',
      key: 'mjenispenjualan.vcNama',
      query: '',
    );

    final response = await _jenisPenjualanGetDataDTOApi.getData(
      action: "getJenisPenjualan",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _jenispenjualan = response.right.data.data;
      notify();
    }
  }

  Future<void> _fetchValuta() async {
    final filters = ValutaGetFilter(
      limit: 10,
    );

    final search = ValutaGetSearch(
      term: 'like',
      key: 'mvaluta.vcNama',
      query: '',
    );

    final response = await _valutaGetDataDTOApi.getData(
      action: "getValuta",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _valuta = response.right.data.data;
      notify();
    }
  }


  Future<void> _fecthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    _nama = json.decode(userDataJson!)['nama'];
    _admingrup = json.decode(userDataJson)['admingrup'];
  }

  void setisLoadingMore(bool isLoadingMore) {
    _isLoadingMore = isLoadingMore;
    notify();
  }

  Future<void> _fetchDetailItem() async {
    setBusy(true);
    final ListDetailItem? detailItem = await _sharedPreferencesService.get(
      SharedPrefKeys.detailItemOrderJual,
    );
    _detailItems = detailItem?.items ?? [];
    setBusy(false);
  }

  void setselectedjenispenjualan(JenisPenjualanGetDataContent? jenispenjualan) {
    _selectedJenisPenjualan = jenispenjualan;
    notify();
  }

  void addItemtoList(CreateOrderJualDetailRequest detailItem) {
    _detailItems.add(detailItem);
    notify();
  }

  void _updateSharedPreferences() {
    _sharedPreferencesService.set(
      SharedPrefKeys.detailItemOrderJual,
      ListDetailItem(
        items: _detailItems,
      ),
    );
  }

  void clearItem() {
    _detailItems.clear();
    _updateSharedPreferences();
  }

  void clearItemAtIndex(int index) {
    _detailItems.removeAt(index);
    _updateSharedPreferences();
    notify();
  }

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    notify();
  }

  void setselectedsales(GetDataContent? sales) {
    _selectedSales = sales;
    notify();
  }

  void setselectedgudang(GetDataContent? gudang) {
    _selectedGudang = gudang;
    notify();
  }

  void setselectedarea(AreaGetDataContent? area) {
    _selectedArea = area;
    notify();
  }

  void setselectedvaluta(ValutaGetDataContent? valuta) {
    _selectedValuta = valuta;
    notify();
  }

  Future<bool> addOrderJualModel({
    required final String dtTanggal,
    required final String dtTanggalKirim,
    required final int intJenis,
    required final int intJTHari,
    required final int decKurs,
    required final int decUM1,
    required final int decUM2,
    required final int decUM3,
    required final int decTotalUMC,
    required final int decTotalBiaya,
    required final int decSubTotal,
    required final int decPPN,
    required final int decPPNNominal,
    required final int decDPP,
    required final int decSisa,
    required final int intEksport,
  }) async {
    final response = await _setOrderJualDetailBonusDTOApi.setOrderJual(
      action: "addOrderJual",
      formatcode: "thorderjual",
      dtTanggal: dtTanggal,
      dtTanggalKirim: dtTanggalKirim,
      intNomorMCustomer: _selectedCustomer?.intNomor ?? 0,
      intNomorMSales: _selectedSales?.intNomor ?? 0,
      intNomorMJenisPenjualan: _selectedJenisPenjualan?.intNomor ?? 0,
      intNomorMValuta: _selectedValuta?.intNomor ?? 0,
      intNomorMGudang: _selectedGudang?.intNomor ?? 0,
      intNomorMArea: _selectedArea?.intNomor ?? 0,
      intJenis: intJenis,
      decKurs: decKurs,
      intJTHari: intJTHari,
      decPPN: decPPN,
      decPPNNominal: decPPNNominal,
      decUM1: decUM1,
      decUM2: decUM2,
      decUM3: decUM3,
      decTotalUMC: decTotalUMC,
      decTotalBiaya: decTotalBiaya,
      decSubTotal: decSubTotal,
      decDPP: decDPP,
      decSisa: decSisa,
      intEksport: intEksport,
      detailitem: _detailItems,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> editItemtoList(CreateOrderJualDetailRequest detailItemParam) async {
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
