import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/Comman/common_method.dart';
import '../../widgets/comman_widget.dart';
import '../dashboard_page/controller/dashboard_controller.dart';
import 'controller/document_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:preeti_s_application3/core/app_export.dart';
import 'package:preeti_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:preeti_s_application3/widgets/app_bar/appbar_title_image.dart';
import 'package:preeti_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:preeti_s_application3/widgets/custom_bottom_bar.dart';
import 'package:preeti_s_application3/widgets/custom_outlined_button.dart';

class DocumentScreen extends GetWidget<DocumentController> {
  DocumentScreen({Key? key}) : super(key: key);
  final DocumentController _controller = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: AppbarLeadingImage(
              imagePath: ImageConstant.imgSolarHamburgerMenuBroken,
              margin: EdgeInsets.only(
                left: 0.h,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
                //onTapImage();
              }),
          onPressed: () {
            // Scaffold.of(context).openDrawer();
          },
        ),
        leadingWidth: 80,
        title: Container(
            height: 70.v,
            margin: EdgeInsets.only(left: 0.h, top: 10.v, bottom: 10.v),
            child: Stack(alignment: Alignment.topLeft, children: [
              Container(
                margin: EdgeInsets.only(left: 22.h, top: 17.v, bottom: 10.v),
                child: Image(
                  image: AssetImage(
                    ImageConstant.imgImage2,
                  ),
                ),
              ),
              // AppbarTitleImage(
              //     imagePath: ImageConstant.imgSantaHat1,
              //     margin: EdgeInsets.only(right: 204.h, bottom: 33.v))
            ])),
      ),
      body: Obx(() {
        return SizedBox(
            width: double.maxFinite,
            child: Column(children: [
              SizedBox(height: 19.v),
              Expanded(
                  child: SingleChildScrollView(
                child: _buildDocument(context),
              )),
            ]));
      }),
    );
  }

  /// Section Widget
  Widget _buildDocumentColumn(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (_controller.selectedFiles.value.isEmpty) {
                  await _controller.pickPDF();

                }
              },
              child: DottedBorder(
                  color: theme.colorScheme.primaryContainer,
                  padding: EdgeInsets.only(
                      left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
                  strokeWidth: 1.h,
                  radius: Radius.circular(5),
                  borderType: BorderType.RRect,
                  dashPattern: [10, 10],
                  child: Container(
                      height: 145.v,
                      width: mediaQueryData.size.width * 0.8,
                      padding:
                          EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      decoration: AppDecoration.outlinePrimaryContainer
                          .copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return _controller.selectedFiles.value.isEmpty ||
                                      controller.selectedFiles.value == []
                                  ? CustomImageView(
                                      imagePath: ImageConstant
                                          .imgArrowRightPrimarycontainer,
                                      height: 30.adaptSize,
                                      width: 30.adaptSize)
                                  : SizedBox();
                            }),
                            SizedBox(height: 12.v),
                            Obx(() {
                              print("this is value ${controller.selectedFiles.value}");
                              return _controller.selectedFiles.value.isEmpty ||
                                  controller.selectedFiles.value == []
                                  ? Center(
                                      child: Text(
                                          "msg_drag_or_upload_your".tr,
                                          style: CustomTextStyles
                                              .bodySmallRobotoPrimaryContainer),
                                    )
                                  : SizedBox(
                                      height:
                                          mediaQueryData.size.height * 0.12,
                                      child:Obx(() =>  ListView.separated(
                                          itemBuilder: (context, index) {
                                            return Obx(() => Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4),
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1)),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQueryData
                                                            .size.width *
                                                            0.6,
                                                        child: Text(
                                                          controller
                                                              .selectedFiles
                                                              .value[index]
                                                              .path
                                                              .split('/')
                                                              .last,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _controller
                                                              .selectedFiles
                                                              .removeAt(
                                                              index);
                                                        },
                                                        style: IconButton.styleFrom(
                                                            minimumSize:
                                                            Size(30, 20),
                                                            tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                            padding:
                                                            EdgeInsets
                                                                .zero),
                                                        icon:
                                                        SvgPicture.asset(
                                                          ImageConstant
                                                              .imgDashboardCross,
                                                          color: Colors.red,
                                                          height: 15,
                                                          width: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )));
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(height: 8);
                                          },
                                          itemCount: _controller
                                              .selectedFiles.value.length)),
                                    );
                            })
                          ]))),
            ),
            SizedBox(height: 11.v),
            Align(
                alignment: Alignment.centerRight,
                child: Text("msg_maximum_document".tr,
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontSize: 11, color: Colors.black))),
            SizedBox(height: 30.v),
            Obx(() {
              return _controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomOutlinedButton(
                      width: 216.h,
                      text: "lbl_upload_pdf".tr,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () async {
                        if (_controller.selectedFiles.value.isNotEmpty) {
                          await _controller.uploadPDF(context);
                        } else {
                          CM.showToast("Please select document");
                        }
                      },
                    );
            })
          ],
        ));
  }

  /// Section Widget
  Widget _buildDocument(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 5.v),
        child: Column(children: [
          CW.buildDashboardRow(text: "err_msg_submit".tr),
          SizedBox(height: 10.v),
          Container(
              decoration: AppDecoration.outlineBlack
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CW.statusCard(text: "lbl_upload_document".tr, height: 57.v),
                SizedBox(height: 20.v),
                _buildDocumentColumn(context),
                SizedBox(
                  height: 20.v,
                ),
                Obx(
                  () => CW.termCondition(satOfficerEmail.value),
                ),
                SizedBox(
                  height: 20.v,
                ),
              ]))
        ]));
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapImage() {
    Get.toNamed(
      AppRoutes.settingsScreen,
    );
  }
}
