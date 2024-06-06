import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/networks/posisi_stok_get_data_dto_network.dart';
import 'package:venus/core/view_models/posisi_stok/posisistok_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/spacings.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';

class PosisiStokKomoditiView extends ConsumerStatefulWidget {
  const PosisiStokKomoditiView({Key? key}) : super(key: key);

  @override
  ConsumerState<PosisiStokKomoditiView> createState() => _PosisiStokKomoditiViewState();
}

class _PosisiStokKomoditiViewState extends ConsumerState<PosisiStokKomoditiView> {
  @override
  Widget build(BuildContext context) {
    return ViewModel<PosisiStokKomoditiViewModel>(
      model: PosisiStokKomoditiViewModel(
        posisiStokGetDataDTOApi: ref.read(posisiStokGetDataDTOApi),
      ),
      onModelReady: (PosisiStokKomoditiViewModel model) => model.initModel(),
      builder: (_, PosisiStokKomoditiViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: venusColor.backgroundAtas,
                  title: const Text(
                    'Laporan Posisi Stok Komoditi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  leading: Container(),
                  centerTitle: true,
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
                                        'Filter Data Laporan Posisi Stok Komoditi',
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
                                                  await model.fetchPosisiStok(reload: true);
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
                body: Column(
                  children: [
                    Expanded(
                      child: LazyLoadScrollView(
                        isLoading: model.busy,
                        onEndOfPage: () {
                          if (!model.isLastPage && !model.isLoadingMore) {
                            model.initData();
                          }
                        },
                        child: RefreshIndicator(
                          onRefresh: () async => model.initModel(),
                          child: Stack(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.posisiStok.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24,
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
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
                                                                '${model.posisiStok[index].vcKodeBarang}',
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
                                                        Spacings.verSpace(12),
                                                        Text(
                                                          '${model.posisiStok[index].vcNamaJual}',
                                                          style: const TextStyle(
                                                            fontSize: 15.376,
                                                            color: venusColor.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Spacings.verSpace(12),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  RichText(
                                                                    text: TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text: 'Satuan 1\n',
                                                                          style: TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: venusColor.lightBlack018,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              '${model.posisiStok[index].vcNamaSatuan1}',
                                                                          style: const TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: venusColor.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  RichText(
                                                                    text: TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text: 'Satuan 2\n',
                                                                          style: TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: venusColor.lightBlack018,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              '${model.posisiStok[index].vcNamaSatuan2}',
                                                                          style: const TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: venusColor.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  RichText(
                                                                    text: TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text: 'Satuan 3\n',
                                                                          style: TextStyle(
                                                                            fontSize: 15.376,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: venusColor.lightBlack018,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              '${model.posisiStok[index].vcNamaSatuan3}',
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
                                                            ),
                                                            Spacings.horSpace(20),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacings.verSpace(12),
                                        const Divider(
                                          height: 1,
                                          color: venusColor.lightBlack009,
                                        ),
                                        Spacings.verSpace(12),
                                        Spacings.verSpace(14),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              if (model.isLoadingMore)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: buildLoadingIndicator(), // Menampilkan indikator loading di bawah ListView
                                ),
                            ],
                          ),
                        ),
                      ),
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

  Widget buildLoadingIndicator() {
    return Container(
      color: venusColor.white,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: venusColor.blue001,
          ),
        ),
      ),
    );
  }
}
