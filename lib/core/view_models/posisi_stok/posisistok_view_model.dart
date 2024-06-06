import 'package:flutter/material.dart';
import 'package:venus/core/models/get_data/posisi_stok_get_data_dto.dart';
import 'package:venus/core/networks/posisi_stok_get_data_dto_network.dart';
import 'package:venus/core/view_models/base_view_model.dart';

class PosisiStokKomoditiViewModel extends BaseViewModel {
  PosisiStokKomoditiViewModel({
    required PosisiStokGetDataDTOService posisiStokGetDataDTOApi,
  }) : _posisiStokGetDataDTOApi = posisiStokGetDataDTOApi;

  final PosisiStokGetDataDTOService _posisiStokGetDataDTOApi;

  final List<PosisiStokGetDataContent> _posisiStok = [];
  List<PosisiStokGetDataContent> get posisiStok => _posisiStok;

  late DateTime _selectedDateAkhir = DateTime.now();
  DateTime get selectedDateAkhir => _selectedDateAkhir;

  int _currentPage = 1;
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

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
    _selectedDateAkhir = DateTime.now();
    await fetchPosisiStok(reload: true);
    setBusy(false);
  }

  Future<void> initData() async {
    setisLoadingMore(true);
    _selectedDateAkhir = DateTime.now();
    await fetchPosisiStok();
    setisLoadingMore(false);
  }

  void setLoading(
    bool value, {
    bool skipNotifyListener = false,
  }) {
    _isLoadingMore = value;
    if (!isDisposed && !skipNotifyListener) {
      notifyListeners();
    }
  }

  PosisiStokQuery query() => PosisiStokQuery(
        aKodeBarang: "%",
        aNamaBeli: "%",
        aKategori: "%",
        aBrand: "%",
        aTipe: "%",
        aGroup: "%",
        aGudang: "%",
        aSatuan: "%",
        aShade: "%",
        aPanjang: 0,
        aLebar: 0,
        aTebal: 0,
        aTanggalAkhir: _selectedDateAkhir.toIso8601String().substring(0, 10),
        intNomorMUser: 2,
        aTampilkanNol: 0,
      );

  PosisiStokGetFilter currentFilter = PosisiStokGetFilter(
    limit: 10,
    page: 1,
    query: PosisiStokQuery(
      aKodeBarang: "%",
      aNamaBeli: "%",
      aKategori: "%",
      aBrand: "%",
      aTipe: "%",
      aGroup: "%",
      aGudang: "%",
      aSatuan: "%",
      aShade: "%",
      aPanjang: 0,
      aLebar: 0,
      aTebal: 0,
      aTanggalAkhir: DateTime.now().toIso8601String().substring(0, 10),
      intNomorMUser: 2,
      aTampilkanNol: 0,
    ),
  );
  Future<void> fetchPosisiStok({bool reload = false}) async {
    if (reload) {
      setBusy(true);
      _currentPage = 1;
      _posisiStok.clear();
    } else {
      _isLoadingMore = true;
    }
    try {
      final newFilter = PosisiStokGetFilter(
        limit: currentFilter.limit,
        page: _currentPage,
        query: query(),
      );

      final response = await _posisiStokGetDataDTOApi.getData(
        action: "getPosisiStokKomoditi",
        filters: newFilter,
      );

      if (response.isRight) {
        final List<PosisiStokGetDataContent> posisiStokDataFromApi = response.right.data;
        _isLastPage = posisiStokDataFromApi.length < currentFilter.limit;
        _posisiStok.addAll(posisiStokDataFromApi);
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

  void setisLoadingMore(bool isLoadingMore) {
    _isLoadingMore = isLoadingMore;
    notify();
  }
}
