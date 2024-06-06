import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:venus/core/app_constants/colors.dart';
import 'package:venus/core/view_models/orderjual/edit/updateorderjual_view_model.dart';
import 'package:venus/core/view_models/view_model.dart';
import 'package:venus/ui/shared/loading_overlay.dart';
import 'package:venus/ui/shared/spacings.dart';
import 'package:venus/ui/shared/unfocus_helper.dart';

import '../../../widgets/search_bar.dart' as search;

class EditAreaOrderJual extends ConsumerStatefulWidget {
  const EditAreaOrderJual({
    super.key,
    required this.viewModel,
  });
  final UpdateOrderJualViewModel viewModel;
  @override
  ConsumerState<EditAreaOrderJual> createState() => _EditAreaOrderJualState();
}

class _EditAreaOrderJualState extends ConsumerState<EditAreaOrderJual> {
  final TextEditingController areaController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  double scrollPosition = 0.0;
  bool tabIsHide = false;

  // ignore: unused_field
  bool _isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return ViewModel<UpdateOrderJualViewModel>(
      model: widget.viewModel,
      onModelReady: (UpdateOrderJualViewModel model) => model.fetchArea(reload: true),
      builder: (_, UpdateOrderJualViewModel model, __) {
        return LoadingOverlay(
          isLoading: model.busy,
          child: UnfocusHelper(
            child: Scaffold(
              backgroundColor: venusColor.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                  setState(
                    () {
                      model.searchQuery = '';
                      _searchController.text = "";
                      model.fetchArea(reload: true);
                      _isLoadingMore = false;
                    },
                  );
                },
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
                            Visibility(
                              visible: tabIsHide == false,
                              maintainState: true,
                              maintainAnimation: true,
                              child: AnimatedSlide(
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 200),
                                offset: tabIsHide == false ? Offset.zero : const Offset(0, -1),
                                child: Column(
                                  children: [
                                    AppBar(
                                      backgroundColor: venusColor.backgroundAtas,
                                      title: Text(
                                        'Tambah Area',
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
                            ),
                            Container(
                              color: venusColor.white,
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                              ),
                              child: Column(
                                children: [
                                  Spacings.verSpace(20),
                                  search.SearchBar(
                                    controller: _searchController,
                                    hintText: 'Cari Area',
                                    onFieldSubmitted: (value) {
                                      model.searchQuery = value;
                                      model.fetchArea(reload: true);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sliver: SliverFillRemaining(
                          hasScrollBody: true,
                          fillOverscroll: true,
                          child: LazyLoadScrollView(
                            isLoading: model.busy,
                            onEndOfPage: () {
                              if (!model.isLastPage && !model.isLoadingMore) {
                                model.initData();
                              }
                            },
                            child: Stack(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.area.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      tileColor: venusColor.transparent,
                                      title: Text(
                                        model.area[index].vcNama,
                                      ),
                                      groupValue: model.selectedArea,
                                      value: model.area[index],
                                      onChanged: (value) {
                                        setState(() {
                                          model.setselectedarea(value);
                                        });
                                        Navigator.of(context).pop(true);
                                      },
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
