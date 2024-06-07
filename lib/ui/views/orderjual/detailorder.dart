import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/app_constants/route.dart';
import 'package:venus/core/networks/delete_order_jual_dto.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/utilities/string_utils.dart';
import 'package:venus/core/view_models/orderjual/detail_order_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/spacings.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';
import 'package:venus/ui/views/navbar/navbar_sales_view.dart';
import 'package:venus/ui/views/orderjual/edit/editorderjual.dart';

class DetailOrderPenjualanParam {
  const DetailOrderPenjualanParam({
    required this.nomor,
    required this.mode,
  });

  final int? nomor;
  final String? mode;
}

class DetailOrderPenjualan extends ConsumerStatefulWidget {
  const DetailOrderPenjualan({
    super.key,
    required this.param,
  });
  final DetailOrderPenjualanParam param;
  @override
  ConsumerState<DetailOrderPenjualan> createState() => _DetailOrderPenjualanState();
}

class _DetailOrderPenjualanState extends ConsumerState<DetailOrderPenjualan> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController gudangController = TextEditingController();
  final TextEditingController jatuhtempoController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController jenisPenjualanController = TextEditingController();
  final TextEditingController valutaController = TextEditingController();
  final TextEditingController kursController = TextEditingController();
  final TextEditingController um1Controller = TextEditingController();
  final TextEditingController um2Controller = TextEditingController();
  final TextEditingController um3Controller = TextEditingController();
  final TextEditingController diskonprosentaseController = TextEditingController();
  final TextEditingController diskonnominalController = TextEditingController();
  final TextEditingController dppController = TextEditingController();
  final TextEditingController ppnnominalController = TextEditingController();
  final TextEditingController biayaController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController satuanController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController satuan1Controller = TextEditingController();
  final TextEditingController pricelistController = TextEditingController();
  final TextEditingController penawaranController = TextEditingController();
  final TextEditingController nettoController = TextEditingController();
  final TextEditingController subtotalController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  // ignore: unused_element
  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailOrderPenjualanViewModel>(
      model: DetailOrderPenjualanViewModel(
        orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        setDeleteOrderJualDTOApi: ref.read(setDeleteOrderJualDTOApi),
        nomor: widget.param.nomor!,
      ),
      onModelReady: (DetailOrderPenjualanViewModel model) => model.initModel(),
      builder: (_, DetailOrderPenjualanViewModel model, __) {
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
                  child: LoadingOverlay(
                    isLoading: model.busy,
                    child: CustomScrollView(
                      slivers: [
                        SliverStickyHeader(
                          sticky: true,
                          header: AnimatedSlide(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 200),
                            offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor: venusColor.backgroundAtas,
                                  title: Text(
                                    'Detail Order Jual',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: tabIsHide == false ? 18 : 14,
                                    ),
                                  ),
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
                                  actions: [
                                    PopupMenuButton<String>(
                                      iconColor: venusColor.black,
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            value: 'edit',
                                            child: ElevatedButton(
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
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.editorderjual,
                                                  arguments: EditOrderJualParam(
                                                    nomor: model.orderjual[0].intNomor,
                                                    mode: 'edit',
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.edit,
                                                    color: venusColor.black,
                                                  ),
                                                  Spacings.horSpace(10),
                                                  const Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      color: venusColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'delete',
                                            child: ElevatedButton(
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
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Hapus Data Order'),
                                                      content: const Text('Apakah anda yakin menghapus order ini?'),
                                                      actions: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            TextButton(
                                                              child: const Text('Ya'),
                                                              onPressed: () async {
                                                                bool success = await model.deleteOrderJualModel(
                                                                  intDeleteUserID: 1,
                                                                );
                                                                // ignore: use_build_context_synchronously
                                                                Navigator.pop(context);
                                                                // Tutup dialog konfirmasi pertama
                                                                if (success) {
                                                                  // Jika berhasil, tampilkan dialog berhasil
                                                                  showDialog(
                                                                    // ignore: use_build_context_synchronously
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text('Berhasil'),
                                                                        content: const Text('Order berhasil dihapus.'),
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
                                                                                  // 1 = Aktifitas Sales
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  // Jika gagal, tampilkan dialog gagal
                                                                  showDialog(
                                                                    // ignore: use_build_context_synchronously
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: const Text('Gagal'),
                                                                        content: const Text('Gagal menghapus order.'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                            child: const Text('OK'),
                                                                            onPressed: () {
                                                                              Navigator.pop(
                                                                                  context); // Tutup dialog gagal
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text('Tidak'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Tutup dialog konfirmasi pertama
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.delete,
                                                    color: venusColor.red,
                                                  ),
                                                  Spacings.horSpace(10),
                                                  const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: venusColor.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                  // centerTitle: true,
                                  toolbarHeight: tabIsHide == false ? kToolbarHeight : kToolbarHeight - 10,
                                ),
                              ],
                            ),
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
                                        const Row(
                                          children: [
                                            Text(
                                              'Kode',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: venusColor.lightBlack011,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(5),
                                        TextFormField(
                                          controller: kodeController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: model.orderjual[0].vcKode,
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
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
                                          readOnly: true,
                                        ),
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
                                                DateFormat('dd/MM/yyyy').format(
                                                  DateTime.tryParse('${model.orderjual[0].dtTanggal}') ??
                                                      DateTime.now(),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: venusColor.black,
                                                  fontWeight: FontWeight.bold,
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
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Tanggal Kirim',
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
                                              surfaceTintColor: Colors.white,
                                              shadowColor: const Color(0x00000000),
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DateFormat('dd/MM/yyyy').format(
                                                    DateTime.tryParse('${model.orderjual[0].dtTanggalKirim}') ??
                                                        DateTime.now(),
                                                  ),
                                                  style: const TextStyle(
                                                    color: venusColor.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
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
                                        TextFormField(
                                          controller: gudangController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].kodeGudang} - ${model.orderjual[0].gudang}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].intJTHari}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                              child: SizedBox(
                                                height: 48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      model.orderjual[0].intJenis == 1
                                                          ? "CBD"
                                                          : model.orderjual[0].intJenis == 2
                                                              ? "COD"
                                                              : model.orderjual[0].intJenis == 3
                                                                  ? "CREDIT"
                                                                  : model.orderjual[0].intJenis == 4
                                                                      ? "CGD-TC"
                                                                      : "",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: venusColor.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_drop_down_sharp,
                                                      color: venusColor.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Retail',
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
                                          controller: jenisPenjualanController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].jenisPenjualan}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          children: [
                                            Text(
                                              'Customer',
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
                                          controller: customerController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].customer}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        TextFormField(
                                          controller: salesController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].sales}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                        TextFormField(
                                          controller: areaController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                            hintText: '${model.orderjual[0].area}',
                                            hintStyle: const TextStyle(
                                              color: venusColor.black,
                                              fontWeight: FontWeight.w500,
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
                                                        child: TextFormField(
                                                          controller: valutaController,
                                                          readOnly: true,
                                                          decoration: InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                                                            hintText: '${model.orderjual[0].valuta}',
                                                            hintStyle: const TextStyle(
                                                              color: venusColor.black,
                                                              fontWeight: FontWeight.w500,
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
                                                    textAlign: TextAlign.end,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(left: 16, top: 6, bottom: 6, right: 16),
                                                      hintText:
                                                          model.orderjual[0].decKurs.toString().replaceAll('.0', ''),
                                                      hintStyle: const TextStyle(
                                                        color: venusColor.black,
                                                        fontWeight: FontWeight.w500,
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Spacings.verSpace(14),
                                        const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'DETAIL BARANG',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: venusColor.lightBlack008,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(14),
                                        const Divider(
                                          color: Colors.grey,
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
                                          itemCount: model.orderjualdetail.length,
                                          itemBuilder: (contect, index) {
                                            // final detailItems = model.orderjualdetail[index];
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
                                                                '${model.orderjualdetail[index].kodeBarang}',
                                                                style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: venusColor.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacings.verSpace(5),
                                                        Text(
                                                          '${model.orderjualdetail[index].vcNamaJual}',
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
                                                              '${model.orderjualdetail[index].decJumlahUnit.toString().replaceAll('.0', '')} ${model.orderjualdetail[index].satuan1}',
                                                              style: const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w400,
                                                                color: venusColor.black,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Berat : ${model.orderjualdetail[index].decBerat}'
                                                                  .toString()
                                                                  .replaceAll('.0', ''),
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
                                                            double.parse(
                                                                model.orderjualdetail[index].decSubTotal != null
                                                                    ? '${model.orderjualdetail[index].decSubTotal}'
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
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjual[0].decTotal != null
                                                                ? '${model.orderjual[0].decTotal}'
                                                                : '0'),
                                                            symbol: '',
                                                          ),
                                                          style: const TextStyle(
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.w500,
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
                                                          child: SizedBox(
                                                            width: 207,
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
                                                                    contentPadding: const EdgeInsets.only(
                                                                      left: 16,
                                                                      top: 6,
                                                                      bottom: 6,
                                                                    ),
                                                                    hintText: model.orderjual[0].decDisc
                                                                        .toString()
                                                                        .replaceAll('.0', ''),
                                                                    hintStyle: const TextStyle(
                                                                      color: venusColor.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14,
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors.grey, width: 1.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors.blue, width: 1.0),
                                                                    ),
                                                                  ),
                                                                  keyboardType: TextInputType.number,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.allow(
                                                                      RegExp(r'[0-9]'),
                                                                    ),
                                                                  ],
                                                                  readOnly: true,
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
                                                                  StringUtils.rupiahFormat(
                                                                    // ignore: unnecessary_null_comparison
                                                                    double.parse(
                                                                        model.orderjual[0].decDiscNominal != null
                                                                            ? '${model.orderjual[0].decDiscNominal}'
                                                                            : '0'),
                                                                    symbol: '',
                                                                  ),
                                                                  style: const TextStyle(
                                                                    color: venusColor.black,
                                                                    fontWeight: FontWeight.w500,
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
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjual[0].decTotalBiaya != null
                                                                ? '${model.orderjual[0].decTotalBiaya}'
                                                                : '0'),
                                                            symbol: '',
                                                          ),
                                                          style: const TextStyle(
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.w500,
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
                                                                textAlign: TextAlign.right,
                                                                onChanged: (value) {},
                                                                decoration: InputDecoration(
                                                                  contentPadding: const EdgeInsets.only(
                                                                    left: 16,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 16,
                                                                  ),
                                                                  hintText: model.orderjual[0].decUM1
                                                                      .toString()
                                                                      .replaceAll('.0', ''),
                                                                  hintStyle: const TextStyle(
                                                                    color: venusColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 14,
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.grey, width: 1.0),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.blue, width: 1.0),
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
                                                                textAlign: TextAlign.right,
                                                                onChanged: (value) {},
                                                                decoration: InputDecoration(
                                                                  contentPadding: const EdgeInsets.only(
                                                                    left: 16,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 16,
                                                                  ),
                                                                  hintText: model.orderjual[0].decUM2
                                                                      .toString()
                                                                      .replaceAll('.0', ''),
                                                                  hintStyle: const TextStyle(
                                                                    color: venusColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 14,
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.grey, width: 1.0),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.blue, width: 1.0),
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
                                                                textAlign: TextAlign.right,
                                                                onChanged: (value) {},
                                                                decoration: InputDecoration(
                                                                  contentPadding: const EdgeInsets.only(
                                                                    left: 16,
                                                                    top: 6,
                                                                    bottom: 6,
                                                                    right: 6,
                                                                  ),
                                                                  hintText: model.orderjual[0].decUM3
                                                                      .toString()
                                                                      .replaceAll('.0', ''),
                                                                  hintStyle: const TextStyle(
                                                                    color: venusColor.black,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 14,
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.grey, width: 1.0),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors.blue, width: 1.0),
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
                                                                    StringUtils.rupiahFormat(
                                                                      // ignore: unnecessary_null_comparison
                                                                      double.parse(
                                                                          model.orderjual[0].decTotalUMC != null
                                                                              ? '${model.orderjual[0].decTotalUMC}'
                                                                              : '0'),
                                                                      symbol: '',
                                                                    ),
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
                                                                    StringUtils.rupiahFormat(
                                                                      // ignore: unnecessary_null_comparison
                                                                      double.parse(model.orderjual[0].decDPP != null
                                                                          ? '${model.orderjual[0].decDPP}'
                                                                          : '0'),
                                                                      symbol: '',
                                                                    ),
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
                                              Column(
                                                children: [
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
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 48,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      '${model.orderjual[0].decPPN.toString().replaceAll('.0', '')}%',
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
                                                            Spacings.horSpace(10),
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 48,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  children: [
                                                                    Text(
                                                                      StringUtils.rupiahFormat(
                                                                        // ignore: unnecessary_null_comparison
                                                                        double.parse(
                                                                            model.orderjual[0].decPPNNominal != null
                                                                                ? '${model.orderjual[0].decPPNNominal}'
                                                                                : '0'),
                                                                        symbol: '',
                                                                      ),
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
                                                ],
                                              ),
                                              Spacings.verSpace(14),
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sisa',
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
                                                          StringUtils.rupiahFormat(
                                                            // ignore: unnecessary_null_comparison
                                                            double.parse(model.orderjual[0].decSisa != null
                                                                ? '${model.orderjual[0].decSisa}'
                                                                : '0'),
                                                            symbol: '',
                                                          ),
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
                                  ),
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
              ),
            ),
          ),
        );
      },
    );
  }

  String _getStatusPPNText(int statusppn) {
    switch (statusppn) {
      case 0:
        return 'Non-PPN';
      case 1:
        return 'PPN';
      default:
        return '-';
    }
  }
}
