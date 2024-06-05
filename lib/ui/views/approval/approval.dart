import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/networks/order_jual_get_data_dto_network.dart';
import 'package:venus/core/view_models/approval/approval_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';

class ApprovalView extends ConsumerStatefulWidget {
  const ApprovalView({Key? key}) : super(key: key);

  @override
  ConsumerState<ApprovalView> createState() => _ApprovalViewState();
}

class _ApprovalViewState extends ConsumerState<ApprovalView> {
  @override
  Widget build(BuildContext context) {
    return ViewModel<ApprovalViewModel>(
        model: ApprovalViewModel(
          orderJualGetDataDTOApi: ref.read(orderJualGetDataDTOApi),
        ),
        onModelReady: (ApprovalViewModel model) => model.initModel(),
        builder: (_, ApprovalViewModel model, __) {
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
                  ),
                  // body: Column(
                  //   children: [
                  //     Expanded(
                  //       child: LazyLoadScrollView(
                  //         isLoading: model.busy,
                  //         onEndOfPage: () => model.isLastPage == false ? model.fetchOrderJual() : null,
                  //         child: RefreshIndicator(
                  //           onRefresh: () async => model.initModel(),
                  //           child: ListView.builder(
                  //               shrinkWrap: true,
                  //               itemCount: model.orderjual.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return Padding(
                  //                   padding: const EdgeInsets.only(
                  //                     top: 24,
                  //                     left: 24,
                  //                     right: 24,
                  //                   ),
                  //                   child: Column(
                  //                     children: [
                  //                       Column(
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               Expanded(
                  //                                 child: ElevatedButton(
                  //                                   style: ElevatedButton.styleFrom(
                  //                                     padding: const EdgeInsets.all(0),
                  //                                     backgroundColor: Color(Colors.transparent.value),
                  //                                     surfaceTintColor: Colors.white,
                  //                                     shadowColor: const Color(0x00000000),
                  //                                     shape: RoundedRectangleBorder(
                  //                                       borderRadius: BorderRadius.circular(0),
                  //                                     ),
                  //                                   ),
                  //                                   onPressed: () {
                  //                                     Navigator.pushNamed(
                  //                                       context,
                  //                                       Routes.approvaldetailorder,
                  //                                       arguments: ApprovalDetailOrderParam(
                  //                                         nomor: model.orderjual[index].nomor,
                  //                                         mode: 'view',
                  //                                       ),
                  //                                     );
                  //                                   },
                  //                                   child: Row(
                  //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                     children: [
                  //                                       Column(
                  //                                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                                         children: <Widget>[
                  //                                           Row(
                  //                                             mainAxisAlignment: MainAxisAlignment.center,
                  //                                             crossAxisAlignment: CrossAxisAlignment.center,
                  //                                             children: [
                  //                                               Container(
                  //                                                 width: 120,
                  //                                                 height: 25,
                  //                                                 decoration: const BoxDecoration(
                  //                                                   borderRadius: BorderRadius.all(Radius.circular(5)),
                  //                                                   color: venusColor.lightBlue006,
                  //                                                 ),
                  //                                                 child: Text(
                  //                                                   model.orderjual[index].kode,
                  //                                                   textAlign: TextAlign.center,
                  //                                                   style: const TextStyle(
                  //                                                     fontSize: 14,
                  //                                                     fontWeight: FontWeight.bold,
                  //                                                     color: venusColor.white,
                  //                                                   ),
                  //                                                 ),
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                           Spacings.verSpace(5),
                  //                                           Row(
                  //                                             children: [
                  //                                               Text(
                  //                                                 '${model.orderjual[index].customer}',
                  //                                                 style: const TextStyle(
                  //                                                   fontSize: 15.376,
                  //                                                   color: venusColor.black,
                  //                                                   fontWeight: FontWeight.bold,
                  //                                                 ),
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                           Spacings.verSpace(5),
                  //                                           Row(
                  //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                             children: [
                  //                                               RichText(
                  //                                                 text: TextSpan(
                  //                                                   children: [
                  //                                                     const TextSpan(
                  //                                                       text: 'Sales\n',
                  //                                                       style: TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.normal,
                  //                                                         color: venusColor.lightBlack018,
                  //                                                       ),
                  //                                                     ),
                  //                                                     TextSpan(
                  //                                                       text: '${model.orderjual[index].sales}',
                  //                                                       style: const TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.bold,
                  //                                                         color: venusColor.black,
                  //                                                       ),
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                               Spacings.horSpace(20),
                  //                                               RichText(
                  //                                                 text: TextSpan(
                  //                                                   children: [
                  //                                                     const TextSpan(
                  //                                                       text: 'Tanggal\n',
                  //                                                       style: TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.normal,
                  //                                                         color: venusColor.lightBlack018,
                  //                                                       ),
                  //                                                     ),
                  //                                                     TextSpan(
                  //                                                       text: model.orderjual[index].tanggal != null
                  //                                                           ? DateFormat('dd MMMM yyyy').format(
                  //                                                               DateTime.tryParse(model
                  //                                                                       .orderjual[index].tanggal!) ??
                  //                                                                   DateTime.now(),
                  //                                                             )
                  //                                                           : '', // Jika tanggal null atau kosong, tampilkan string kosong
                  //                                                       style: const TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.bold,
                  //                                                         color: venusColor.black,
                  //                                                       ),
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                               Spacings.horSpace(20),
                  //                                               RichText(
                  //                                                 text: TextSpan(
                  //                                                   children: [
                  //                                                     const TextSpan(
                  //                                                       text: 'Status\n',
                  //                                                       style: TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.normal,
                  //                                                         color: venusColor.lightBlack018,
                  //                                                       ),
                  //                                                     ),
                  //                                                     TextSpan(
                  //                                                       text: _getStatusText(
                  //                                                           '${model.orderjual[index].statusapproval}'),
                  //                                                       style: TextStyle(
                  //                                                         fontSize: 15.376,
                  //                                                         fontWeight: FontWeight.bold,
                  //                                                         color: _getStatusColor(
                  //                                                             '${model.orderjual[index].statusapproval}'),
                  //                                                       ),
                  //                                                     )
                  //                                                   ],
                  //                                                 ),
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                         ],
                  //                                       ),
                  //                                       Row(
                  //                                         children: [
                  //                                           IconButton(
                  //                                             onPressed: () {
                  //                                               Navigator.pushNamed(
                  //                                                 context,
                  //                                                 Routes.approvaldetailorder,
                  //                                                 arguments: ApprovalDetailOrderParam(
                  //                                                   nomor: model.orderjual[index].nomor,
                  //                                                   mode: 'view',
                  //                                                 ),
                  //                                               );
                  //                                             },
                  //                                             icon: const Icon(
                  //                                               Icons.chevron_right,
                  //                                               size: 30,
                  //                                               color: venusColor.black,
                  //                                             ),
                  //                                           ),
                  //                                         ],
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           Spacings.verSpace(12),
                  //                           const Divider(
                  //                             height: 1,
                  //                             color: venusColor.lightBlack009,
                  //                           ),
                  //                           Spacings.verSpace(12),
                  //                         ],
                  //                       ),
                  //                       Spacings.verSpace(14),
                  //                     ],
                  //                   ),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          );
        });
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Approved':
        return 'Disetujui';
      case 'Pending':
        return 'Menunggu';
      case 'Rejected':
        return 'Ditolak';
      default:
        return '-';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return venusColor.green005;
      case 'Pending':
        return venusColor.yellow001;
      case 'Rejected':
        return venusColor.red004;
      default:
        return venusColor.black;
    }
  }
}
