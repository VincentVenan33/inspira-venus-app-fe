import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/core/models/get_data/area_get_data_dto.dart';
import 'package:venus/core/models/get_data/get_data_dto.dart';
import 'package:venus/core/models/get_data/jenis_penjualan_get_data_dto.dart';
import 'package:venus/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:venus/core/models/get_data/valuta_get_data_dto.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/networks/area_get_data_dto_network.dart';
import 'package:venus/core/networks/delete_order_jual_detail_dto.dart';
import 'package:venus/core/networks/get_data_dto_network.dart';
import 'package:venus/core/networks/jenis_penjualan_get_data_dto_network.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/networks/update_order_jual_only_dto.dart';
import 'package:venus/core/networks/valuta_get_data_dto_network.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class UpdateOrderJualViewModel extends BaseViewModel {
  UpdateOrderJualViewModel({
    required OrderJualGetDataDTOService orderJualGetDataDTOApi,
    required GetDataDTOService getDataDTOApi,
    required JenisPenjualanGetDataDTOService jenisPenjualanGetDataDTOApi,
    required AreaGetDataDTOService areaGetDataDTOApi,
    required ValutaGetDataDTOService valutaGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
    required SetUpdateOrderJualOnlyDTOService setUpdateOrderJualOnlyDTOApi,
    required SetDeleteOrderJualDetailDTOService setDeleteOrderJualDetailDTOApi,
    required int nomor,
  })  : _orderJualGetDataDTOApi = orderJualGetDataDTOApi,
        _getDataDTOApi = getDataDTOApi,
        _jenisPenjualanGetDataDTOApi = jenisPenjualanGetDataDTOApi,
        _areaGetDataDTOApi = areaGetDataDTOApi,
        _valutaGetDataDTOApi = valutaGetDataDTOApi,
        _sharedPreferencesService = sharedPreferencesService,
        _setUpdateOrderJualOnlyDTOApi = setUpdateOrderJualOnlyDTOApi,
        _setDeleteOrderJualDetailDTOApi = setDeleteOrderJualDetailDTOApi,
        _nomor = nomor;

  final OrderJualGetDataDTOService _orderJualGetDataDTOApi;
  final GetDataDTOService _getDataDTOApi;
  final JenisPenjualanGetDataDTOService _jenisPenjualanGetDataDTOApi;
  final AreaGetDataDTOService _areaGetDataDTOApi;
  final ValutaGetDataDTOService _valutaGetDataDTOApi;
  // ignore: unused_field
  final SharedPreferencesService _sharedPreferencesService;
  final SetUpdateOrderJualOnlyDTOService _setUpdateOrderJualOnlyDTOApi;
  final SetDeleteOrderJualDetailDTOService _setDeleteOrderJualDetailDTOApi;
  final int _nomor;

  final TextEditingController kodeController = TextEditingController();
  final TextEditingController gudangController = TextEditingController();
  final TextEditingController jatuhtempoController = TextEditingController();
  final TextEditingController jenisPenjualanController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController kursController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayalainController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();

  int _subtotal = 0;
  int _diskonnominal = 0;
  int _dpp = 0;
  int _ppn = 0;
  int _biayalain = 0;
  int _total = 0;

  OrderJualGetDataContent? _orderjual;
  OrderJualGetDataContent? get orderjual => _orderjual;

  List<OrderJualGetDataContent> _orderjualdetail = [];
  List<OrderJualGetDataContent> get orderjualdetail => _orderjualdetail;

  final List<CreateOrderJualDetailRequest> _detailItems = [];
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

  int get selectedPembayaran => _selectedPembayaran;
  int _selectedPembayaran = 0;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  // ignore: unused_field
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  late DateTime selectedDate;
  late DateTime selectedDateKirim;

  void setLoading(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _isLoadingMore = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  void hitung() {
    double disc1Percentage = (double.tryParse(diskonprosentaseController.text) ?? 0) / 100;

    _subtotal = int.parse(subtotalController.text);
    debugPrint('totalSubtotal $_subtotal');

    _diskonnominal = (_subtotal * disc1Percentage).toInt();
    diskonnominalController.text = _diskonnominal.toString();

    _dpp = _subtotal - _diskonnominal.toInt();
    dppController.text = _dpp.toString();
    ppnnominalController.text = _ppn.toString();
    debugPrint('dpp : $_dpp');
    debugPrint('ppn : $_ppn');
    _biayalain = 0;
    debugPrint('biayalain : $_biayalain');
    _total = _dpp + _ppn + _biayalain;
    totalController.text = _total.toString();
    notifyListeners();
  }

  void hitung2() {
    _dpp = int.parse(dppController.text);
    debugPrint('dpp : $_dpp');
    _ppn = int.parse(ppnnominalController.text);
    debugPrint('ppn : $_ppn');
    _biayalain = int.parse(biayalainController.text);
    _total = _dpp + _ppn + _biayalain;
    totalController.text = _total.toString();
    notifyListeners();
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
    await fetchOrderJual(reload: true);
    await _fetchOrderJualDetail(_nomor);
    await _fetchJenisPenjualan();
    await _fetchValuta();
    await _fecthUser();
    setBusy(false);
    diskonprosentaseController.addListener(hitung);
    subtotalController.addListener(hitung);
    biayalainController.addListener(hitung2);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    await fetchCustomer();
    await fetchGudang();
    await fetchSales();
    await fetchArea();
    setisLoadingMore(false);
  }

  OrderJualGetFilter currentOrderJualFilter = OrderJualGetFilter(
    limit: 10,
    page: 10,
  );
  Future<void> fetchOrderJual({bool reload = false}) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'thorderjual.vcKode',
      query: '',
    );
    if (reload) {
      _currentPage = 1;
    }
    try {
      final newFilter = OrderJualGetFilter(
        limit: currentOrderJualFilter.limit,
        page: _currentPage,
        sort: 'DESC',
        intNomor: _nomor,
        orderby: 'thorderjual.intNomor',
      );

      final response = await _orderJualGetDataDTOApi.getData(
        action: "getOrderJual",
        filters: newFilter,
        search: search,
      );

      if (response.isRight) {
        _orderjual = response.right.data.data[0];
        kodeController.text = _orderjual?.vcKode ?? '';
        customerController.text = "${_orderjual?.kodeCustomer ?? ''} - ${_orderjual?.customer ?? ''}";
        gudangController.text = "${_orderjual?.kodeGudang ?? ''} - ${_orderjual?.gudang ?? ''}";
        salesController.text = "${_orderjual?.kodeSales ?? ''} - ${_orderjual?.sales ?? ''}";
        jatuhtempoController.text = _orderjual?.intJTHari.toString() ?? '';
        jenisPenjualanController.text = _orderjual?.jenisPenjualan ?? '';
        areaController.text = _orderjual?.area ?? '';
        kursController.text = _orderjual?.decKurs.toString() ?? '';
        // diskonprosentaseController.text = _orderjual?.diskonprosentase.toString() ?? '';
        // diskonnominalController.text = _orderjual?.diskonnominal.toString() ?? '';
        dppController.text = _orderjual?.decDPP.toString() ?? '';
        ppnnominalController.text = _orderjual?.decPPNNominal.toString() ?? '';
        biayalainController.text = _orderjual?.decTotalBiaya.toString() ?? '';
        totalController.text = _orderjual?.decTotal.toString() ?? '';
        subtotalController.text = _orderjual?.decSubTotal.toString() ?? '';
        selectedDate = DateTime.parse(_orderjual?.dtTanggal ?? '');
        selectedDateKirim = DateTime.parse(_orderjual?.dtTanggalKirim ?? '');
        setselectedPembayaran(_orderjual!.intTOP?.toInt() ?? 0);
        notify();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _fetchOrderJualDetail(int nomorOrderJual) async {
    final search = OrderJualGetSearch(
      term: 'like',
      key: 'tdorderjual.intNomorHeader',
      query: '$nomorOrderJual',
    );
    debugPrint('intNomorHeader $nomorOrderJual');
    final filters = OrderJualGetFilter(
      limit: 10,
      page: 1,
    );

    final response = await _orderJualGetDataDTOApi.getData(
      action: "getOrderJualDetail",
      filters: filters,
      search: search,
    );

    if (response.isRight) {
      _orderjualdetail = response.right.data.data;
      notify();
    } else {}
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
      // Add this else part
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
    _nama = json.decode(userDataJson!)['vcNama'];
    _admingrup = json.decode(userDataJson)['vcJabatan'];
  }

  void setisLoadingMore(bool isLoadingMore) {
    _isLoadingMore = isLoadingMore;
    notify();
  }

  void setselectedcustomer(GetDataContent? customer) {
    _selectedCustomer = customer;
    customerController.text = customer?.vcNama ?? '';
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

  void setselectedjenispenjualan(JenisPenjualanGetDataContent? jenispenjualan) {
    _selectedJenisPenjualan = jenispenjualan;
    notify();
  }

  void setselectedvaluta(ValutaGetDataContent? valuta) {
    _selectedValuta = valuta;
    notify();
  }

  void setselectedPembayaran(int value) {
    _selectedPembayaran = value;
    notify();
  }

  Future<bool> updateOrderJualOnlyModel({
    required final String dtTanggal,
    required final String dtTanggalKirim,
    required final int intNomorMJenisPenjualan,
    required final int intNomorMValuta,
    required final int intNomorMGudang,
    required final int intNomorMCustomer,
    required final int intNomorMSales,
    required final int intJenis,
    required final int intNomorMCabang,
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
    required final String vcKeterangan,
    required final String vcKeteranganFJ,
    required final String vcKeteranganKW,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setUpdateOrderJualOnlyDTOApi.seUpdatetOrderJual(
      action: "addOrderJual",
      dtTanggal: dtTanggal,
      dtTanggalKirim: dtTanggalKirim,
      intNomorMCustomer: _selectedCustomer?.intNomor ?? 0,
      intNomorMSales: intNomorMSales,
      intNomorMJenisPenjualan: intNomorMJenisPenjualan,
      intNomorMValuta: intNomorMValuta,
      intNomorMGudang: intNomorMGudang,
      intNomorMCabang: intNomorMCabang,
      intJenis: intJenis,
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
      vcKeterangan: vcKeterangan,
      vcKeteranganFJ: vcKeteranganFJ,
      vcKeteranganKW: vcKeteranganKW,
      intNomor: _nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }

  Future<bool> deleteOrderJualDetailModel({
    required int intDeleteUserID,
    required int nomor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setDeleteOrderJualDetailDTOApi.setDeleteOrderJualDetail(
      action: "softDeleteOrderJualDetail",
      intDeleteUserID: json.decode(userDataJson!)['intNomor'],
      intNomor: nomor,
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
