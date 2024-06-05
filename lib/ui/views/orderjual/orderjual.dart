import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/app_constants/route.dart';
import 'package:venus/core/networks/approval_order_jual_dto_network.dart';
import 'package:venus/core/networks/delete_order_jual_dto.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/view_models/orderjual/orderjual_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';
import 'package:venus/ui/views/orderjual/detailorder.dart';
import 'package:venus/ui/views/orderjual/edit/editorderjual.dart';

import '../../shared/spacings.dart';

class OrderJualView extends ConsumerStatefulWidget {
  const OrderJualView({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderJualView> createState() => _OrderJualViewState();
}

class _OrderJualViewState extends ConsumerState<OrderJualView> {
  final TextEditingController _searchController = TextEditingController();

  // ignore: unused_element
  void _onSearchTextChanged(String query) {
    debugPrint("Teks pencarian: $query");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<OrderJualViewModel>(
        model: OrderJualViewModel(
          orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
          setApprovalOrderJualDTOApi: ref.read(setApprovalOrderJualDTOApi),
          setDeleteOrderJualDTOApi: ref.read(setDeleteOrderJualDTOApi),
          // nomor: ,
        ),
        onModelReady: (OrderJualViewModel model) => model.initModel(),
        builder: (_, OrderJualViewModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: venusColor.white,
                  appBar: AppBar(
                    backgroundColor: venusColor.backgroundAtas,
                    title: const Text(
                      'Daftar Order Jual',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    centerTitle: true,
                    leading: Container(),
                    actions: [
                      IconButton(
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
                                          'Filter Data Order Jual',
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
                                    Spacings.verSpace(22),
                                    Container(
                                      color: venusColor.transparent,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Spacings.verSpace(8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Tanggal Awal',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: venusColor.lightBlack011,
                                                      ),
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
                                                        onPressed: () => model.pickDateAwal(context),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              DateFormat('dd/MM/yyyy').format(model.selectedDateAwal),
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
                                                  ],
                                                ),
                                              ),
                                              Spacings.horSpace(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Tanggal Akhir',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: venusColor.lightBlack011,
                                                      ),
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
                                                        onPressed: () => model.pickDateAkhir(context),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              DateFormat('dd/MM/yyyy').format(model.selectedDateAkhir),
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
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacings.verSpace(22),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    await model.fetchOrderJual(reload: true);
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
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
                                                    'Filter',
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
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.filter_alt_outlined,
                        ),
                        color: Colors.black,
                        iconSize: 20,
                      ),
                    ],
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      model.initModel();
                      setState(() {
                        model.fetchOrderJual(reload: true);
                      });
                    },
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            children: [
                              // search.SearchBar(
                              //   controller: _searchController,
                              //   hintText: 'Cari',
                              //   onFieldSubmitted: (value) {
                              //     model.searchQuery = value;
                              //     model.fetchOrderJual(reload: true);
                              //   },
                              // ),
                              // Spacings.verSpace(
                              //   24,
                              // ),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: 41,
                              //   child: ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all<Color>(venusColor.floatButtonSalesColor),
                              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              //         RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(8.0),
                              //         ),
                              //       ),
                              //     ),
                              //     onPressed: () {
                              //       Navigator.pushNamed(
                              //         context,
                              //         Routes.daftarorderjual,
                              //       );
                              //     },
                              //     child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         const Text(
                              //           'Katalog Produk',
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //         Spacings.horSpace(15),
                              //         const Icon(
                              //           Icons.book_outlined,
                              //           color: venusColor.white,
                              //           size: 24,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Spacings.verSpace(24),
                            ],
                          ),
                        ),
                        Expanded(
                          child: LazyLoadScrollView(
                            isLoading: model.busy,
                            onEndOfPage: () => model.isLastPage == false ? model.fetchOrderJual() : null,
                            child: RefreshIndicator(
                              onRefresh: () async => model.initModel(),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) => Spacings.verSpace(12),
                                  itemCount: model.orderjual.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(0),
                                              backgroundColor: Color(Colors.transparent.value),
                                              surfaceTintColor: Colors.white,
                                              shadowColor: const Color(0x00000000),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.detailorderpenjualan,
                                                arguments: DetailOrderPenjualanParam(
                                                  nomor: model.orderjual[index].intNomor,
                                                  mode: 'view',
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                width: 120,
                                                                height: 25,
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  color: venusColor.lightBlue006,
                                                                ),
                                                                child: Text(
                                                                  model.orderjual[index].vcKode,
                                                                  textAlign: TextAlign.center,
                                                                  style: const TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: venusColor.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacings.verSpace(5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${model.orderjual[index].customer}',
                                                                style: const TextStyle(
                                                                  fontSize: 15.376,
                                                                  color: venusColor.black,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacings.verSpace(5),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  RichText(
                                                                    text: TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text: 'Sales\n',
                                                                          style: TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: venusColor.lightBlack018,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: '${model.orderjual[index].sales}',
                                                                          style: const TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: venusColor.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacings.horSpace(50),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                      text: 'Tanggal\n',
                                                                      style: TextStyle(
                                                                        fontSize: 15.376,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: venusColor.lightBlack018,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: model.orderjual[index].dtTanggal != null
                                                                          ? DateFormat('dd MMMM yyyy').format(
                                                                              DateTime.tryParse(model
                                                                                      .orderjual[index].dtTanggal!) ??
                                                                                  DateTime.now(),
                                                                            )
                                                                          : '', // Jika tanggal null atau kosong, tampilkan string kosong
                                                                      style: const TextStyle(
                                                                        fontSize: 15.376,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: venusColor.black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Spacings.horSpace(50),
                                                              // RichText(
                                                              //   text: TextSpan(
                                                              //     children: [
                                                              //       const TextSpan(
                                                              //         text: 'Status\n',
                                                              //         style: TextStyle(
                                                              //           fontSize: 15.376,
                                                              //           fontWeight: FontWeight.normal,
                                                              //           color: venusColor.lightBlack018,
                                                              //         ),
                                                              //       ),
                                                              //       TextSpan(
                                                              //         text: model.orderjual[index].intApproved == 1
                                                              //             ? 'Disetujui'
                                                              //             : 'Pending',
                                                              //         style: TextStyle(
                                                              //           fontSize: 15.376,
                                                              //           fontWeight: FontWeight.bold,
                                                              //           color: model.orderjual[index].intApproved == 1
                                                              //               ? venusColor.green005
                                                              //               : venusColor
                                                              //                   .yellow001, // Kuning jika pending
                                                              //         ),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          PopupMenuButton<String>(
                                                            iconColor: venusColor.black,
                                                            itemBuilder: (BuildContext context) {
                                                              return [
                                                                PopupMenuItem<String>(
                                                                  value: 'edit',
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: const EdgeInsets.all(0),
                                                                      backgroundColor:
                                                                          Color(venusColor.transparent.value),
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
                                                                          nomor: model.orderjual[index].intNomor,
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
                                                                      backgroundColor:
                                                                          Color(venusColor.transparent.value),
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
                                                                      Navigator.pop(context);
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return AlertDialog(
                                                                            title: const Text('Hapus Data Order'),
                                                                            content: const Text(
                                                                                'Apakah anda yakin menghapus order ini?'),
                                                                            actions: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  TextButton(
                                                                                    child: const Text('Ya'),
                                                                                    onPressed: () async {
                                                                                      bool success = await model
                                                                                          .deleteOrderJualModel(
                                                                                        intDeleteUserID: 1,
                                                                                        intNomor: model
                                                                                            .orderjual[index].intNomor,
                                                                                      );
                                                                                      // ignore: use_build_context_synchronously
                                                                                      Navigator.pop(context);
                                                                                      // Tutup dialog konfirmasi pertama
                                                                                      if (success) {
                                                                                        // Jika berhasil, tampilkan dialog berhasil
                                                                                        showDialog(
                                                                                          // ignore: use_build_context_synchronously
                                                                                          context: context,
                                                                                          builder:
                                                                                              (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title: const Text(
                                                                                                  'Berhasil'),
                                                                                              content: const Text(
                                                                                                  'Order berhasil dihapus.'),
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child:
                                                                                                      const Text('OK'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(
                                                                                                        context);
                                                                                                    model.initModel();
                                                                                                    setState(() {
                                                                                                      model
                                                                                                          .fetchOrderJual(
                                                                                                              reload:
                                                                                                                  true);
                                                                                                    });
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
                                                                                          builder:
                                                                                              (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title:
                                                                                                  const Text('Gagal'),
                                                                                              content: const Text(
                                                                                                  'Gagal menghapus order.'),
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child:
                                                                                                      const Text('OK'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(
                                                                                                        context);
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
                                                                          'Hapus',
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
                                                                  value: 'setuju',
                                                                  child: Column(
                                                                    children: [
                                                                      Visibility(
                                                                        visible:
                                                                            model.orderjual[index].intApproved == 0,
                                                                        child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                            padding: const EdgeInsets.all(0),
                                                                            backgroundColor:
                                                                                Color(venusColor.transparent.value),
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
                                                                            Navigator.pop(context);
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title:
                                                                                      const Text('Setujui Data Order'),
                                                                                  content: const Text(
                                                                                      'Apakah anda yakin menyetujui order ini?'),
                                                                                  actions: <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment:
                                                                                          MainAxisAlignment
                                                                                              .spaceBetween,
                                                                                      children: [
                                                                                        TextButton(
                                                                                          child: const Text('Ya'),
                                                                                          onPressed: () async {
                                                                                            bool success = await model
                                                                                                .approvalOrderJualModel(
                                                                                              intApproved: 1,
                                                                                              dtApproveTime: DateFormat(
                                                                                                      'dd/MM/yyyy HH:mm:ss')
                                                                                                  .format(
                                                                                                      DateTime.now()),
                                                                                              intNomor: model
                                                                                                  .orderjual[index]
                                                                                                  .intNomor,
                                                                                            );
                                                                                            // ignore: use_build_context_synchronously
                                                                                            Navigator.pop(context);
                                                                                            // Tutup dialog konfirmasi pertama
                                                                                            if (success) {
                                                                                              // Jika berhasil, tampilkan dialog berhasil
                                                                                              showDialog(
                                                                                                // ignore: use_build_context_synchronously
                                                                                                context: context,
                                                                                                builder: (BuildContext
                                                                                                    context) {
                                                                                                  return AlertDialog(
                                                                                                    title: const Text(
                                                                                                        'Berhasil'),
                                                                                                    content: const Text(
                                                                                                        'Order berhasil disetujui.'),
                                                                                                    actions: <Widget>[
                                                                                                      TextButton(
                                                                                                        child:
                                                                                                            const Text(
                                                                                                                'OK'),
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(
                                                                                                              context);
                                                                                                          model
                                                                                                              .initModel();
                                                                                                          setState(() {
                                                                                                            model.fetchOrderJual(
                                                                                                                reload:
                                                                                                                    true);
                                                                                                          });
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
                                                                                                builder: (BuildContext
                                                                                                    context) {
                                                                                                  return AlertDialog(
                                                                                                    title: const Text(
                                                                                                        'Gagal'),
                                                                                                    content: const Text(
                                                                                                        'Gagal menyetujui order.'),
                                                                                                    actions: <Widget>[
                                                                                                      TextButton(
                                                                                                        child:
                                                                                                            const Text(
                                                                                                                'OK'),
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(
                                                                                                              context);
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
                                                                                Icons.check,
                                                                                color: venusColor.green006,
                                                                              ),
                                                                              Spacings.horSpace(10),
                                                                              const Text(
                                                                                'Setuju',
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
                                                                      Visibility(
                                                                        visible:
                                                                            model.orderjual[index].intApproved == 1,
                                                                        child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                            padding: const EdgeInsets.all(0),
                                                                            backgroundColor:
                                                                                Color(venusColor.transparent.value),
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
                                                                            Navigator.pop(context);
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: const Text(
                                                                                      'Batal setujui Data Order'),
                                                                                  content: const Text(
                                                                                      'Apakah anda yakin batal menyetujui order ini?'),
                                                                                  actions: <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment:
                                                                                          MainAxisAlignment
                                                                                              .spaceBetween,
                                                                                      children: [
                                                                                        TextButton(
                                                                                          child: const Text('Ya'),
                                                                                          onPressed: () async {
                                                                                            bool success = await model
                                                                                                .approvalOrderJualModel(
                                                                                              intApproved: 0,
                                                                                              dtApproveTime: DateFormat(
                                                                                                      'dd/MM/yyyy HH:mm:ss')
                                                                                                  .format(
                                                                                                      DateTime.now()),
                                                                                              intNomor: model
                                                                                                  .orderjual[index]
                                                                                                  .intNomor,
                                                                                            );
                                                                                            // ignore: use_build_context_synchronously
                                                                                            Navigator.pop(context);
                                                                                            // Tutup dialog konfirmasi pertama
                                                                                            if (success) {
                                                                                              // Jika berhasil, tampilkan dialog berhasil
                                                                                              showDialog(
                                                                                                // ignore: use_build_context_synchronously
                                                                                                context: context,
                                                                                                builder: (BuildContext
                                                                                                    context) {
                                                                                                  return AlertDialog(
                                                                                                    title: const Text(
                                                                                                        'Berhasil'),
                                                                                                    content: const Text(
                                                                                                        'Order berhasil batal disetujui.'),
                                                                                                    actions: <Widget>[
                                                                                                      TextButton(
                                                                                                        child:
                                                                                                            const Text(
                                                                                                                'OK'),
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(
                                                                                                              context);
                                                                                                          model
                                                                                                              .initModel();
                                                                                                          setState(() {
                                                                                                            model.fetchOrderJual(
                                                                                                                reload:
                                                                                                                    true);
                                                                                                          });
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
                                                                                                builder: (BuildContext
                                                                                                    context) {
                                                                                                  return AlertDialog(
                                                                                                    title: const Text(
                                                                                                        'Gagal'),
                                                                                                    content: const Text(
                                                                                                        'Gagal batal menyetujui order.'),
                                                                                                    actions: <Widget>[
                                                                                                      TextButton(
                                                                                                        child:
                                                                                                            const Text(
                                                                                                                'OK'),
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(
                                                                                                              context);
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
                                                                                Icons.close,
                                                                                color: venusColor.red001,
                                                                              ),
                                                                              Spacings.horSpace(10),
                                                                              const Text(
                                                                                'Batalkan',
                                                                                style: TextStyle(
                                                                                  color: venusColor.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ];
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacings.verSpace(12),
                                          const Divider(
                                            height: 1,
                                            color: venusColor.lightBlack009,
                                          ),
                                          Spacings.verSpace(12),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Spacings.verSpace(14),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    key: const Key("customer_FAB"),
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.addorderjual,
                      );
                    },
                    backgroundColor: venusColor.floatButtonSalesColor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 31.5,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
