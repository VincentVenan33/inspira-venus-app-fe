import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/app_constants/route.dart';
import 'package:venus/core/models/get_data/area_get_data_dto.dart';
import 'package:venus/core/models/get_data/get_data_dto.dart';
import 'package:venus/core/networks/area_get_data_dto_network.dart';
import 'package:venus/core/networks/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/networks/get_data_dto_network.dart';
import 'package:venus/core/networks/jenis_penjualan_get_data_dto_network.dart';
import 'package:venus/core/networks/valuta_get_data_dto_network.dart';
import 'package:venus/core/services/shared_preferences_service.dart';
import 'package:venus/core/utilities/string_utils.dart';
import 'package:venus/core/view_models/orderjual/addorderjual_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/spacings.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';
import 'package:venus/ui/views/navbar/navbar_sales_view.dart';
import 'package:venus/ui/views/orderjual/edititemdetail.dart';

class AddOrderJual extends ConsumerStatefulWidget {
  const AddOrderJual({super.key});

  @override
  ConsumerState<AddOrderJual> createState() => _AddOrderJualState();
}

class _AddOrderJualState extends ConsumerState<AddOrderJual> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController gudangController = TextEditingController();
  final TextEditingController jatuhtempoController = TextEditingController();
  final TextEditingController jenisPenjualanController = TextEditingController();
  final TextEditingController valutaController = TextEditingController();
  final TextEditingController um1Controller = TextEditingController();
  final TextEditingController um2Controller = TextEditingController();
  final TextEditingController um3Controller = TextEditingController();
  final TextEditingController totalumController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController kursController = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayaController = TextEditingController();
  final TextEditingController sisaController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController isiController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  late DateTime _selectedDate;

  int _subtotal = 0;
  int _diskonnominal = 0;
  int _dpp = 0;
  int _ppn = 0;
  int _biayalain = 0;
  int _total = 0;
  int _um1 = 0;
  int _um2 = 0;
  int _um3 = 0;
  int _totalum = 0;

  @override
  void initState() {
    super.initState();
    diskonprosentaseController.addListener(hitung);
    subtotalController.addListener(hitung);
    totalumController.addListener(hitung);
    biayaController.addListener(hitung2);
    _selectedDate = DateTime.now();
  }

  void hitung() {
    setState(
      () {
        double disc1Percentage = (double.tryParse(diskonprosentaseController.text) ?? 0) / 100;

        _subtotal = int.parse(subtotalController.text);
        debugPrint('totalSubtotal $_subtotal');

        _diskonnominal = (_subtotal * disc1Percentage).toInt();
        diskonnominalController.text = _diskonnominal.toString();

        if (selectedPPN == 0) {
          _ppn = 0;
          ppnnominalController.text = '0';
        } else {
          _ppn = (_dpp * 0.11).toInt();
          ppnnominalController.text = _ppn.toString();
        }

        _um1 = int.tryParse(um1Controller.text) ?? 0;
        _um2 = int.tryParse(um2Controller.text) ?? 0;
        _um3 = int.tryParse(um3Controller.text) ?? 0;

        _totalum = _um1 + _um2 + _um3;

        debugPrint('totalum : $_totalum');

        totalumController.text = _totalum.toString();

        _dpp = _subtotal - _diskonnominal.toInt() - _totalum;
        dppController.text = _dpp.toString();
        ppnnominalController.text = _ppn.toString();
        debugPrint('dpp : $_dpp');
        debugPrint('ppn : $_ppn');
        _biayalain = 0;
        debugPrint('biayalain : $_biayalain');
        _total = _dpp + _ppn + _biayalain;
        sisaController.text = _total.toString();
      },
    );
  }

  void hitung2() {
    setState(
      () {
        _dpp = int.parse(dppController.text);
        debugPrint('dpp : $_dpp');
        _ppn = int.parse(ppnnominalController.text);
        debugPrint('ppn : $_ppn');
        _biayalain = int.parse(biayaController.text);
        _total = _dpp + _ppn + _biayalain;
        sisaController.text = _total.toString();
      },
    );
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (date != null) {
      setState(
        () {
          _selectedDate = date;
        },
      );
      debugPrint('tanggal $_selectedDate');
    }
  }

  int selectedPembayaran = 0;
  int selectedPPN = 0;

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<AddOrderJualViewModel>(
      model: AddOrderJualViewModel(
        getDataDTOApi: ref.read(getDataDTOApi),
        jenisPenjualanGetDataDTOApi: ref.read(jenisPenjualanGetDataDTOApi),
        areaGetDataDTOApi: ref.read(areaGetDataDTOApi),
        valutaGetDataDTOApi: ref.read(valutaGetDataDTOApi),
        sharedPreferencesService: ref.read(sharedPrefProvider),
        setOrderJualDetailBonusDTOApi: ref.read(setOrderJualDetailBonusDTOApi),
      ),
      onModelReady: (AddOrderJualViewModel model) => model.initModel(),
      builder: (_, AddOrderJualViewModel model, __) {
        return UnfocusHelper(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: venusColor.white,
              body: RefreshIndicator(
                onRefresh: () async => model.initModel(),
                child: NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    if (notification.direction == ScrollDirection.reverse) {
                      setState(() {
                        tabIsHide = true;
                      });
                    } else if (notification.direction == ScrollDirection.forward) {
                      setState(() {
                        tabIsHide = false;
                      });
                    }

                    return true;
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverStickyHeader(
                        sticky: true,
                        header: Column(
                          children: [
                            Column(
                              children: [
                                AnimatedSlide(
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 200),
                                  offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                  child: Column(
                                    children: [
                                      AppBar(
                                        backgroundColor: venusColor.backgroundAtas,
                                        leading: IconButton(
                                          onPressed: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Routes.navBarSales,
                                              (route) => false,
                                              arguments: NavbarSalesViewParam(
                                                menuIndex: 1,
                                                // 1 = Aktifitas Sales
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                          ),
                                        ),
                                        title: Text(
                                          'Tambah Order Jual',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: tabIsHide == false ? 18 : 14,
                                          ),
                                        ),
                                        // centerTitle: true,
                                        toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 19,
                                  ),
                                  child: Column(
                                    children: [
                                      // const Row(
                                      //   children: [
                                      //     Text(
                                      //       'Kode*',
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w400,
                                      //         color: venusColor.lightBlack011,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Spacings.verSpace(5),
                                      // SizedBox(
                                      //   width: double.infinity,
                                      //   height: 32,
                                      //   child: TextFormField(
                                      //     controller: kodeController,
                                      //     decoration: InputDecoration(
                                      //       contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                      //       hintText: 'C-BRI-00009',
                                      //       hintStyle: const TextStyle(
                                      //         color: venusColor.lightBlack011,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //       fillColor: venusColor.lightBlack019, // Add this line to set the background color
                                      //       filled: true,
                                      //       enabledBorder: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(8.0),
                                      //         borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //         borderRadius: BorderRadius.circular(8.0),
                                      //         borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                      //       ),
                                      //     ),
                                      //     readOnly: true,
                                      //   ),
                                      // ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Tanggal',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Container(
                                        width: double.infinity,
                                        height: 48,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: venusColor.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.calendar_month,
                                              color: venusColor.lightBlack016,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Tanggal',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(
                                              8,
                                            ),
                                            side: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            backgroundColor: venusColor.transparent,
                                            surfaceTintColor: venusColor.transparent,
                                            shadowColor: const Color(0x00000000),
                                          ),
                                          onPressed: _pickDate,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: venusColor.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.calendar_month,
                                                color: venusColor.lightBlack016,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Gudang',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addgudangorderjual,
                                            arguments: model,
                                          ).then((withResponse) {
                                            if (withResponse == false) {
                                              return;
                                            }
                                            if (model.selectedGudang != null) {
                                              GetDataContent value = model.selectedGudang!;
                                              setState(() {
                                                gudangController.text = "${value.vcKode} - ${value.vcNama}";
                                              });
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(venusColor.transparent.value),
                                          surfaceTintColor: venusColor.transparent,
                                          shadowColor: venusColor.transparent,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.zero,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    gudangController.text,
                                                    style: const TextStyle(
                                                      color: venusColor.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          gudangController.clear();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.refresh,
                                                        color: venusColor.lightBlack014,
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.search,
                                                      color: venusColor.lightBlack014,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Jatuh Tempo',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      TextFormField(
                                        controller: jatuhtempoController,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: venusColor.black,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                          hintText: 'Jatuh Tempo (Hari)',
                                          hintStyle: const TextStyle(
                                            color: venusColor.lightBlack015,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                          ),
                                        ),
                                        keyboardType:
                                            const TextInputType.numberWithOptions(signed: true, decimal: false),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Pembayaran',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButton<int>(
                                              value: selectedPembayaran,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedPembayaran = (newValue ?? 0);
                                                });
                                              },
                                              isExpanded: true,
                                              underline: Container(),
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 0,
                                                  enabled: false,
                                                  child: Text('Pilih Pembayaran'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 1,
                                                  child: Text('CBD'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 2,
                                                  child: Text('COD'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 3,
                                                  child: Text('CREDIT'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 4,
                                                  child: Text('CGD-TC'),
                                                ),
                                              ],
                                              icon: const Icon(Icons.arrow_drop_down),
                                              iconSize: 24,
                                              alignment: AlignmentDirectional.centerEnd, // Alignment for the icon
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Jenis',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 29,
                                                  vertical: 29,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: venusColor.lightBlack020,
                                                    width: 1,
                                                  ),
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(25),
                                                    topRight: Radius.circular(25),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Browse Jenis Penjualan',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon: const Icon(Icons.close),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacings.verSpace(8),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: model.jenispenjualan.length,
                                                        itemBuilder: (context, index) {
                                                          return RadioListTile(
                                                            tileColor: venusColor.transparent,
                                                            title: Text(
                                                              model.jenispenjualan[index].vcNama,
                                                            ),
                                                            groupValue: model.selectedJenisPenjualan,
                                                            value: model.jenispenjualan[index],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                model.setselectedjenispenjualan(value);
                                                              });
                                                              Navigator.of(context).pop(true);
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(venusColor.transparent.value),
                                          surfaceTintColor: venusColor.transparent,
                                          shadowColor: venusColor.transparent,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.zero,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              model.selectedJenisPenjualan?.vcNama ?? 'Pilih Jenis Penjualan',
                                              style: const TextStyle(
                                                color: venusColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: venusColor.lightBlack014,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Pelanggan*',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addpelangganorderjual,
                                            arguments: model,
                                          ).then((withResponse) {
                                            if (withResponse == false) {
                                              return;
                                            }
                                            if (model.selectedCustomer != null) {
                                              GetDataContent value = model.selectedCustomer!;
                                              String? sales = value.namasales;
                                              String? area = value.namaarea;
                                              setState(() {
                                                customerController.text = value.vcNama;
                                                salesController.text = sales!;
                                                areaController.text = area!;
                                                model.setselectedarea(
                                                  AreaGetDataContent(
                                                    intNomor: value.intNomorMArea ?? 0,
                                                    vcNama: value.namaarea ?? '',
                                                  ),
                                                );
                                                model.setselectedsales(
                                                  GetDataContent(
                                                    intNomor: value.intNomorMSales ?? 0,
                                                    vcNama: value.namasales ?? '',
                                                    vcKode: value.kodesales ?? '',
                                                  ),
                                                );
                                              });
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(venusColor.transparent.value),
                                          surfaceTintColor: venusColor.transparent,
                                          shadowColor: venusColor.transparent,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.zero,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              customerController.text,
                                              style: const TextStyle(
                                                color: venusColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      customerController.clear();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                    color: venusColor.lightBlack014,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.search,
                                                  color: venusColor.lightBlack014,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'BEX',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addsalesorderjual,
                                            arguments: model,
                                          ).then(
                                            (withResponse) {
                                              if (withResponse == false) {
                                                return;
                                              }
                                              if (model.selectedSales != null) {
                                                GetDataContent value = model.selectedSales!;
                                                setState(
                                                  () {
                                                    salesController.text = value.vcNama;
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(venusColor.transparent.value),
                                          surfaceTintColor: venusColor.transparent,
                                          shadowColor: venusColor.transparent,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.zero,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              salesController.text,
                                              style: const TextStyle(
                                                color: venusColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      salesController.clear();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                    color: venusColor.lightBlack014,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.search,
                                                  color: venusColor.lightBlack014,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        children: [
                                          Text(
                                            'Area',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.addareaorderjual,
                                            arguments: model,
                                          ).then(
                                            (withResponse) {
                                              if (withResponse == false) {
                                                return;
                                              }
                                              if (model.selectedArea != null) {
                                                AreaGetDataContent value = model.selectedArea!;
                                                setState(
                                                  () {
                                                    areaController.text = value.vcNama;
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Color(venusColor.transparent.value),
                                          surfaceTintColor: venusColor.transparent,
                                          shadowColor: venusColor.transparent,
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                              Radius.zero,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              areaController.text,
                                              style: const TextStyle(
                                                color: venusColor.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      areaController.clear();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                    color: venusColor.lightBlack014,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.search,
                                                  color: venusColor.lightBlack014,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacings.verSpace(14),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Valuta',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: venusColor.lightBlack011,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return Container(
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 29,
                                                                  vertical: 29,
                                                                ),
                                                                constraints: BoxConstraints(
                                                                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: venusColor.lightBlack020,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius: const BorderRadius.only(
                                                                    topLeft: Radius.circular(25),
                                                                    topRight: Radius.circular(25),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          'Browse Valuta',
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon: const Icon(Icons.close),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Spacings.verSpace(8),
                                                                    Expanded(
                                                                      child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        physics: const NeverScrollableScrollPhysics(),
                                                                        itemCount: model.valuta.length,
                                                                        itemBuilder: (context, index) {
                                                                          return RadioListTile(
                                                                            tileColor: venusColor.transparent,
                                                                            title: Text(
                                                                              model.valuta[index].vcNama,
                                                                            ),
                                                                            groupValue: model.selectedValuta,
                                                                            value: model.valuta[index],
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                model.setselectedvaluta(value);
                                                                              });
                                                                              Navigator.of(context).pop(true);
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          padding: const EdgeInsets.all(0),
                                                          backgroundColor: Color(venusColor.transparent.value),
                                                          surfaceTintColor: venusColor.transparent,
                                                          shadowColor: venusColor.transparent,
                                                          shape: const RoundedRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.all(
                                                              Radius.zero,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              model.selectedValuta?.vcNama ?? '',
                                                              style: const TextStyle(
                                                                color: venusColor.black,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.search,
                                                                  color: venusColor.lightBlack014,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacings.horSpace(12),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      'Kurs',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14,
                                                        color: venusColor.lightBlack011,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                TextFormField(
                                                  controller: kursController,
                                                  textAlign: TextAlign.right,
                                                  onChanged: (value) {},
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.only(
                                                      left: 16,
                                                      top: 6,
                                                      bottom: 6,
                                                      right: 16,
                                                    ),
                                                    hintText: 'Masukkan Kurs',
                                                    hintStyle: const TextStyle(
                                                      color: venusColor.lightBlack015,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                                                    ),
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                      RegExp(r'[0-9]'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Ekspor / PPN',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButton<int>(
                                              value: selectedPPN,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedPPN = (newValue ?? 0);
                                                  hitung();
                                                });
                                              },
                                              isExpanded: true, // Make the dropdown take the full width
                                              underline: Container(), // Remove default underline
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 0,
                                                  child: Text('Export'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 1,
                                                  child: Text('PPN'),
                                                ),
                                              ],
                                              icon: const Icon(Icons.arrow_drop_down),
                                              iconSize: 24,
                                              alignment: AlignmentDirectional.centerEnd, // Alignment for the icon
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      Spacings.verSpace(14),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'DETAIL BARANG',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: venusColor.lightBlack008,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red, // Warna ikon hapus
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Hapus Barang'),
                                                    content: const Text(
                                                        'Apakah anda yakin mengahapus semua detail barang ini?'),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            child: const Text('Ya'),
                                                            onPressed: () {
                                                              setState(() {
                                                                model.clearItem();
                                                                int totalSubtotal = model.detailItems
                                                                    .fold(0, (sum, item) => sum + (item.decSubTotal));
                                                                double disc1Percentage =
                                                                    (double.tryParse(diskonprosentaseController.text) ??
                                                                            0) /
                                                                        100;

                                                                _subtotal = totalSubtotal;
                                                                debugPrint('totalSubtotal $_diskonnominal');

                                                                _diskonnominal = (_subtotal * disc1Percentage).toInt();
                                                                diskonnominalController.text =
                                                                    _diskonnominal.toString();
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text('Tidak'),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.only(
                                    top: 0,
                                    left: 15,
                                    right: 19,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      color: Colors.grey,
                                    );
                                  },
                                  itemCount: model.detailItems.length,
                                  itemBuilder: (contect, index) {
                                    final detailItems = model.detailItems[index];
                                    return ListTile(
                                      title: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Image.network(
                                                'https://indraco.com/gmb/tanpalogo/TUGUBUAYA/TB-301.png',
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${detailItems.kodeBarang}',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                          color: venusColor.black,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        // final bool response = await model.editItemtoList(
                                                        //   CreateOrderJualDetailRequest(
                                                        //     nomormhbarang: detailItems.nomormhbarang,
                                                        //     nomormhsatuan: detailItems.nomormhsatuan,
                                                        //     kode: detailItems.kode,
                                                        //     nama: detailItems.nama,
                                                        //     qty: detailItems.qty,
                                                        //     netto: detailItems.netto,
                                                        //     disctotal: detailItems.disctotal,
                                                        //     discdirect: detailItems.discdirect,
                                                        //     disc3: detailItems.disc3,
                                                        //     disc2: detailItems.disc2,
                                                        //     disc1: detailItems.disc1,
                                                        //     satuanqty: detailItems.satuanqty,
                                                        //     isi: detailItems.isi,
                                                        //     satuanisi: detailItems.satuanisi,
                                                        //     harga: detailItems.harga,
                                                        //     subtotal: detailItems.subtotal,
                                                        //     konversisatuan: detailItems.konversisatuan,
                                                        //   ),
                                                        // );

                                                        // if (response) {
                                                        Navigator.pushNamed(
                                                          // ignore: use_build_context_synchronously
                                                          context,
                                                          Routes.editDetailCatalog,
                                                          arguments: EditDetailOrderParam(
                                                              nomor: index, mode: 'edit', detailItem: detailItems),
                                                        );
                                                        // }
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red, // Warna ikon hapus
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text('Hapus Barang'),
                                                              content: const Text(
                                                                  'Apakah anda yakin mengahapus detail barang ini?'),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      child: const Text('Ya'),
                                                                      onPressed: () {
                                                                        model.clearItemAtIndex(index);
                                                                        setState(() {
                                                                          int totalSubtotal = model.detailItems.fold(0,
                                                                              (sum, item) => sum + (item.decSubTotal));
                                                                          double disc1Percentage = (double.tryParse(
                                                                                      diskonprosentaseController
                                                                                          .text) ??
                                                                                  0) /
                                                                              100;

                                                                          _subtotal = totalSubtotal;
                                                                          debugPrint('totalSubtotal $_diskonnominal');

                                                                          _diskonnominal =
                                                                              (_subtotal * disc1Percentage).toInt();
                                                                          diskonnominalController.text =
                                                                              _diskonnominal.toString();
                                                                        });
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text('Tidak'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Text(
                                                  '${detailItems.barang}',
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color: venusColor.black,
                                                  ),
                                                ),
                                                Spacings.verSpace(5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${detailItems.decJumlah1} ${detailItems.satuan1}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w400,
                                                        color: venusColor.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Berat : ${detailItems.decBerat}'.toString().replaceAll('.0', ''),
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w400,
                                                        color: venusColor.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Text(
                                                  StringUtils.rupiahFormat(
                                                    // ignore: unnecessary_null_comparison
                                                    double.parse(model.detailItems[index].decSubTotal != null
                                                        ? '${model.detailItems[index].decSubTotal}'
                                                        : '0'),
                                                    symbol: 'Subtotal (Rp) : ',
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color: venusColor.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 19,
                                  ),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 48,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  subtotalController.text =
                                                      '${model.detailItems.fold(0, (sum, item) => sum + (item.decSubTotal))}',
                                                  style: const TextStyle(
                                                    color: venusColor.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Discount',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TextFormField(
                                                        controller: diskonprosentaseController,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            // hitung();
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan diskon',
                                                          hintStyle: const TextStyle(
                                                            color: venusColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 48,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          diskonnominalController.text,
                                                          style: const TextStyle(
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Biaya',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 48,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  biayaController.text,
                                                  style: const TextStyle(
                                                    color: venusColor.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'UM 1',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: venusColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: um1Controller,
                                                        onChanged: (value) {
                                                          hitung();
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan UM1',
                                                          hintStyle: const TextStyle(
                                                            color: venusColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'UM 2',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: venusColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: um2Controller,
                                                        onChanged: (value) {
                                                          hitung();
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan UM 2',
                                                          hintStyle: const TextStyle(
                                                            color: venusColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'UM 3',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: venusColor.lightBlack011,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacings.verSpace(5),
                                                      TextFormField(
                                                        controller: um3Controller,
                                                        onChanged: (value) {
                                                          hitung();
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                          hintText: 'Masukkan UM 3',
                                                          hintStyle: const TextStyle(
                                                            color: venusColor.lightBlack015,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 14,
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.grey, width: 1.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide:
                                                                const BorderSide(color: Colors.blue, width: 1.0),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.allow(
                                                            RegExp(r'[0-9]'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Total UM',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: venusColor.lightBlack011,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      height: 48,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            totalumController.text,
                                                            style: const TextStyle(
                                                              color: venusColor.black,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(14),
                                              ],
                                            ),
                                          ),
                                          Spacings.horSpace(10),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'DPP',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: venusColor.lightBlack011,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      height: 48,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            dppController.text,
                                                            style: const TextStyle(
                                                              color: venusColor.black,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacings.verSpace(14),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'PPN',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: SizedBox(
                                                    height: 48,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '11.00',
                                                          style: TextStyle(
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Spacings.horSpace(10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 48,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          ppnnominalController.text,
                                                          style: const TextStyle(
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(14),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: venusColor.lightBlack011,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacings.verSpace(5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 48,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  sisaController.text,
                                                  style: const TextStyle(
                                                    color: venusColor.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacings.verSpace(164),
                              ],
                            ),
                            childCount: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.katalogproduk,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 124,
                                vertical: 16,
                              ),
                              backgroundColor: venusColor.floatButtonSalesColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Add Detail Barang',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacings.verSpace(28),
                    if (model.detailItems.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (DateFormat('yyyy-MM-dd').format(_selectedDate).isEmpty ||
                                    customerController.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Semua field harus diisi'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return; // Stop further execution
                                }
                                final bool response = await model.addOrderJualModel(
                                  dtTanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                  dtTanggalKirim: DateFormat('yyyy-MM-dd').format(_selectedDate),
                                  intJenis: selectedPembayaran,
                                  intJTHari: int.parse(jatuhtempoController.text),
                                  decKurs: int.parse(kursController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decUM1: int.parse(um1Controller.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decUM2: int.parse(um2Controller.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decUM3: int.parse(um3Controller.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decTotalUMC: int.parse(totalumController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decTotalBiaya: 0,
                                  decSubTotal: int.parse(subtotalController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decPPN: 11,
                                  decPPNNominal: int.parse(ppnnominalController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decDPP: int.parse(dppController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  decSisa: int.parse(sisaController.text.replaceAll(RegExp(r'[^\d-]'), '')),
                                  intEksport: selectedPembayaran,
                                );
                                if (response) {
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Gagal'),
                                        content: const Text('Data Gagal Disimpan'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Succes'),
                                        content: const Text('Data Berhasil Disimpan'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                Routes.navBarSales,
                                                (route) => false,
                                                arguments: NavbarSalesViewParam(
                                                  menuIndex: 1,
                                                ),
                                              );
                                              model.clearItem();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 144,
                                  vertical: 16,
                                ),
                                backgroundColor: venusColor.floatButtonSalesColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customer(BuildContext context, GetDataContent item) {
    return Text(
      item.vcNama,
      style: const TextStyle(
        color: venusColor.black,
      ),
    );
  }
}
