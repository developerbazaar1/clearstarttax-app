import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_constant/api_constant.dart';
import '../../core/validator/validator.dart';
import '../../data/models/SuccessDialogBox/SuccessBox.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title_image.dart';
import '../../widgets/comman_widget.dart';
import 'controller/payment_controller.dart';
import 'models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:preeti_s_application3/core/app_export.dart';
import 'package:preeti_s_application3/core/utils/validation_functions.dart';
import 'package:preeti_s_application3/widgets/custom_outlined_button.dart';
import 'package:preeti_s_application3/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key}) : super(key: key);
  final PaymentController _controller = Get.put(PaymentController());

  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // PaymentController controller = Get.put(PaymentController(PaymentModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var subtitleFontSize = mediaQueryData.size.width*0.033;
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
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          return _controller.getPaymentData.value == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: mediaQueryData.size.width,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 19.v),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.h),
                          child: Column(children: [
                            CW.buildDashboardRow(
                                text: "lbl_payment_heading".tr),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              decoration: AppDecoration.outlineBlack.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10),
                              child: Column(
                                children: [
                                  CW.statusCard(
                                      text: "lbl_payment".tr, height: 57.v),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RadioButtonWidget(
                                        value: _controller.getPaymentData.value!
                                            .data!.data!.pastDue!,
                                        label: "msg_past_due_balance".tr,
                                        widget: Text(
                                          "\$" +
                                              _controller.getPaymentData.value!
                                                  .data!.data!.pastDue
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontSize: subtitleFontSize,
                                              fontWeight: FontWeight.w400
                                              /* 187.5% */
                                              ),
                                        ),
                                      ),
                                      RadioButtonWidget(
                                        value: _controller.getPaymentData.value!
                                            .data!.data!.balance!,
                                        label: "msg_remaining_balance".tr,
                                        widget: Text(
                                          "\$" +
                                              _controller.getPaymentData.value!
                                                  .data!.data!.balance
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontSize: subtitleFontSize,
                                              fontWeight: FontWeight.w400
                                              /* 187.5% */
                                              ),
                                        ),
                                      ),
                                      RadioButtonWidget(
                                        value: _controller
                                                .paymentController.value.text ??
                                            0.toString(),
                                        label: "lbl_other_amount".tr,
                                        widget: Row(
                                          children: [
                                            Text(
                                              '\$',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontSize: subtitleFontSize,
                                                  fontWeight: FontWeight.w400
                                                  /* 187.5% */
                                                  ),
                                            ),
                                            Container(
                                                height: 30,
                                                width: 50.h,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors
                                                          .black, // Adjust the color as needed
                                                      width:
                                                          1.0, // Adjust the width as needed
                                                    ),
                                                  ),
                                                ),
                                                child: CW
                                                    .commonTextFieldForLoginSignUP(
                                                  style: TextStyle(fontSize: subtitleFontSize),
                                                  context: context,
                                                        wantBorder: true,
                                                        initialBorderColor:
                                                            Colors.transparent,
                                                        cursorHeight: 12,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 2),
                                                        readOnly: false,
                                                        controller: _controller
                                                            .paymentController
                                                            .value,
                                                        onChanged: (value) {},
                                                        inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ]))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.v,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.v,
                            ),
                            Container(
                              decoration: AppDecoration.outlineBlack.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10),
                              child: Column(
                                children: [
                                  CW.statusCard(
                                      text: "msg_billing_summary".tr,
                                      height: 57.v),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 15.v),
                                    child: Column(
                                      children: [
                                        billingDetails(
                                            "lbl_total_balance".tr,
                                            "\$" +
                                                double.parse(_controller
                                                        .getPaymentData
                                                        .value!
                                                        .data!
                                                        .billingSummary!
                                                        .data!
                                                        .totalFees
                                                        .toString())
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "lbl_paid".tr,
                                            "\$" +
                                                double.parse(_controller
                                                        .getPaymentData
                                                        .value!
                                                        .data!
                                                        .billingSummary!
                                                        .data!
                                                        .paidAmount
                                                        .toString())
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "lbl_paid2".tr,
                                            _controller
                                                .getPaymentData
                                                .value!
                                                .data!
                                                .billingSummary!
                                                .data!
                                                .paidPercentage
                                                .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "msg_remaining_balance".tr,
                                            "\$" +
                                                double.parse(_controller
                                                        .getPaymentData
                                                        .value!
                                                        .data!
                                                        .billingSummary!
                                                        .data!
                                                        .balance
                                                        .toString())
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "lbl_amount_due".tr,
                                            "\$" +
                                                double.parse(_controller
                                                        .getPaymentData
                                                        .value!
                                                        .data!
                                                        .billingSummary!
                                                        .data!
                                                        .amountDue
                                                        .toString())
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "lbl_next_due_date".tr,
                                            _controller
                                                .getPaymentData
                                                .value!
                                                .data!
                                                .billingSummary!
                                                .data!
                                                .dueDate
                                                .toString()
                                                .toString(),
                                            Colors.black),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        billingDetails(
                                            "lbl_past_due".tr,
                                            _controller
                                                        .getPaymentData
                                                        .value!
                                                        .data!
                                                        .billingSummary!
                                                        .data!
                                                        .pastDue! <
                                                    0
                                                ? "N/A"
                                                : "\$" +
                                                    double.parse(_controller
                                                            .getPaymentData
                                                            .value!
                                                            .data!
                                                            .billingSummary!
                                                            .data!
                                                            .pastDue!
                                                            .toString())
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                            Colors.red),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "lbl_pay_schedule".tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                    /* 187.5% */
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: mediaQueryData
                                                            .size.width * 0.058),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(30, 20),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  onPressed: () {
                                                    PaymentModel.showDateListDialog(
                                                        context,
                                                        _controller
                                                            .getPaymentData
                                                            .value!
                                                            .data!
                                                            .paymentSchedular!);

                                                  },
                                                  child: Text(
                                                    "lbl_click_to_view".tr,
                                                    style: TextStyle(
                                                        color:
                                                            theme.primaryColor,
                                                        fontFamily: 'Poppins',
                                                        fontSize: subtitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w400
                                                        /* 187.5% */
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Form(child: _buildScrollViewSection(context)),
                          ]))));
        }));
  }

  Widget billingDetails(String billngTitle, String billingAmount, Color color) {
    var subtitleFontSize = mediaQueryData.size.width*0.033;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            billngTitle,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500
                /* 187.5% */
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            billingAmount,
            style: TextStyle(
                color: color,
                fontFamily: 'Poppins',
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w400
                /* 187.5% */
                ),
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildNameOnCardSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_name_on_card".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 11.v),
      CustomTextFormField(
          textInputType: TextInputType.text,
          autofocus: false,
          controller: _controller.nameController,
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
          hintText: "msg_enter_card_holder".tr,
          hintStyle: CustomTextStyles.bodyLargeGray60001,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "msg_enter_this_field".tr;
            } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
              return 'msg_enter_name'.tr;
            }

            return null;
          })
    ]);
  }

  Widget _buildInputFeild(String heading, String hintText, validator,
      TextEditingController controller, List<TextInputFormatter> inputformatter,
      {TextInputType? textInputType}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(heading, style: theme.textTheme.titleMedium),
      SizedBox(height: 11.v),
      CustomTextFormField(
          autofocus: false,
          controller: controller,
          inputFormatter: inputformatter,
          textInputType: textInputType,
          hintText: hintText,
          hintStyle: CustomTextStyles.bodyLargeGray60001,
          validator: validator)
    ]);
  }

  Widget zipDetails(TextEditingController controller) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('msg_zip'.tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 11.v),
      CustomTextFormField(
          textInputType: TextInputType.number,
          autofocus: false,
          controller: controller,
          hintText: 'Enter zip code',
          inputFormatter: [
            LengthLimitingTextInputFormatter(5),
            FilteringTextInputFormatter.digitsOnly,
          ],
          hintStyle: CustomTextStyles.bodyLargeGray60001,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "msg_enter_this_field".tr;
            } else if (value.length < 5) {
              return "msg_enter_zip".tr;
            }
            return null;
          })
    ]);
  }

  /// Section Widget
  Widget _buildCardInformationSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("msg_card_information".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 12.v),
      CustomTextFormField(
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "msg_enter_this_field".tr;
            } else if (value.length < 16) {
              return "msg_enter_valid_card".tr;
            } else if (getCreditCardType(value) == "Nothing") {
              return "msg_enter_valid_card".tr;
            }

            return null;
          },
          autofocus: false,
          textInputType: TextInputType.number,
          controller: _controller.cardinformationvalueController,
          hintText: "msg_enter_card_information".tr,
          hintStyle: CustomTextStyles.bodyLargeGray60001)
    ]);
  }

  /// Section Widget
  Widget _buildExpirationSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_expiration".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 10.v),
      Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            width: MediaQuery.of(context).size.width / 2.48,
            padding: EdgeInsets.symmetric(vertical: 1.v, horizontal: 0.h),
            child: CustomTextFormField(
              textInputType: TextInputType.number,
              controller: _controller.monthController,
              hintText: "lbl_mm".tr,
              onChange: (value) {
                _controller.isMonthField.value = true;
              },
              hintStyle: CustomTextStyles.bodyLargeGray60001,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  _controller.isMonthField.value = false;
                  _controller.expirydateValidation.value =
                      "msg_enter_this_field".tr;
                } else if (int.parse(value) >= 13 || int.parse(value) <= 0) {
                  _controller.isMonthField.value = false;
                  _controller.expirydateValidation.value = "msg_enter_month".tr;
                } else {
                  _controller.isMonthField.value = true;
                }

                return null;
              },
              borderDecoration: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _controller.expirydateValidation.value == '' ||
                              _controller.isMonthField.value == true
                          ? Colors.grey
                          : Color.fromARGB(500, 170, 15, 9),
                      width: 1),
                  borderRadius: BorderRadius.circular(5)),
            )),
        Container(
            width: MediaQuery.of(context).size.width / 2.48,
            padding: EdgeInsets.symmetric(vertical: 1.v, horizontal: 0.h),
            child: CustomTextFormField(
              enable: _controller.isMonthField.value ? true : false,
              controller: _controller.yearController,
              textInputType: TextInputType.number,
              hintText: "lbl_yyyy".tr,
              hintStyle: CustomTextStyles.bodyLargeGray60001,
              validator: (value) {
                if (_controller.isMonthField.value == true) {
                  if (value == null || value.trim().isEmpty) {
                    _controller.expirydateValidation.value =
                        "msg_enter_this_field".tr;
                    print(_controller.expirydateValidation.value);
                  } else if (int.parse(value) < DateTime.now().year ||
                      int.parse(value) > 2060) {
                    _controller.expirydateValidation.value =
                        "msg_enter_year".tr;
                  } else {
                    _controller.expirydateValidation.value = '';
                  }
                }
                return null;
              },
              borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: _controller.expirydateValidation.value == '' ||
                              _controller.expirydateValidation.isEmpty &&
                                  _controller.isMonthField.value == true
                          ? Colors.grey
                          : Color.fromARGB(500, 170, 15, 9),
                      width: 1)),
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
            )),
      ])),
      SizedBox(height: 8.v),
      if (_controller.expirydateValidation.value.isNotEmpty)
        Obx(() => Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Text(
                _controller.expirydateValidation.value,
                style: TextStyle(color: Color.fromARGB(500, 170, 15, 9)),
              ),
            ))
    ]);
  }

  /// Section Widget
  Widget _buildCvvSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
          text: TextSpan(children: [
            TextSpan(text: "lbl_cvv2".tr, style: theme.textTheme.titleMedium),
            TextSpan(text: "lbl3".tr, style: CustomTextStyles.titleMediumBold_1)
          ]),
          textAlign: TextAlign.left),
      SizedBox(height: 11.v),
      CustomTextFormField(
        autofocus: false,
        textInputType: TextInputType.number,
        controller: _controller.cvvController,
        hintText: "msg_enter_your_card".tr,
        hintStyle: CustomTextStyles.bodyLargeGray60001,
        inputFormatter: [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Please enter card number";
          } else if (value.length < 3) {
            return "msg_enter_cvv".tr;
          }

          return null;
        },
      ),
    ]);
  }

  /// Section Widget
  Widget _buildEmailAddressSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_email_address2".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 12.v),
      CustomTextFormField(
        autofocus: false,
        controller: _controller.emailController,

        hintStyle: CustomTextStyles.bodyLargeGray60001,
        // textInputAction: TextInputAction.done,
        textInputType: TextInputType.emailAddress,
        validator: (value) => Validator.isEmailValid(value: value),
      )
    ]);
  }

  Widget _transferEmailAddressSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_email_address2".tr, style: theme.textTheme.titleMedium),
      SizedBox(height: 12.v),
      CustomTextFormField(
        autofocus: false,
        controller: _controller.transferEmailController,

        hintStyle: CustomTextStyles.bodyLargeGray60001,
        // textInputAction: TextInputAction.done,
        textInputType: TextInputType.emailAddress,
        validator: (value) => Validator.isEmailValid(value: value),
      )
    ]);
  }

  /// Section Widget
  Widget _buildScrollViewSection(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(height: 22.v),
          CW.statusCard(
              text: "msg_payment_schedule".tr, height: 57.v),

      Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: Column(children: [
            TabBar.secondary(
              padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
              controller: _controller.tabController,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              tabs: <Widget>[
                Tab(
                  text: "msg_credit_card".tr,
                ),
                Tab(text: 'msg_bank_transfer'.tr),
              ],
            ),
            Container(
              height: mediaQueryData.size.height * 1.5,
              child: TabBarView(
                controller: _controller.tabController,
                children: <Widget>[
                  Form(
                    key: _controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNameOnCardSection(),
                        SizedBox(height: 12.v),
                        _buildCardInformationSection(),
                        SizedBox(height: 14.v),
                        _buildExpirationSection(context),
                        _buildCvvSection(),
                        SizedBox(height: 20.v),
                        Text(
                          'msg_billing_address'.tr,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 20.v),
                        _buildInputFeild('msg_street_address1'.tr, 'Enter street address'.tr,
                            (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'msg_enter_name'.tr;
                          }
                          return null;
                        }, _controller.add1Controller, []),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_street_address2'.tr, 'Enter street address'.tr,
                            (value) {
                          return null;
                        }, _controller.add2Controller, []),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_city'.tr, 'Enter city'.tr, (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          }
                          return null;
                        }, _controller.cityController, [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ]),
                        SizedBox(height: 14.v),
                        _stateDropdown(
                            context, _controller.selectValue.value, 1),
                        SizedBox(height: 8.v),
                        zipDetails(_controller.zipController),
                        SizedBox(height: 14.v),
                        _buildEmailAddressSection(),
                        SizedBox(height: 35.v),
                        Obx(() {
                          return _controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: CustomOutlinedButton(
                                      width: 150.h,
                                      text: "lbl_pay".tr,
                                      buttonStyle: ElevatedButton.styleFrom(),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onPressed: () {
                                        _controller.clickOnPayButton(context);
                                      }),
                                );
                        }),
                        SizedBox(height: 20.v),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: EdgeInsets.only(left: 10.h, right: 10.h),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "msg_by_clicking_pay".tr,
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer10,
                                children: [
                                  TextSpan(
                                      text: 'Terms and Conditions.',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url =
                                              'https://clearstarttax.com/paymenttermsandconditions/';
                                          if (await canLaunch(url)) {
                                            await launch(url,
                                                forceWebView: true,
                                                enableJavaScript: true);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                      style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 12))
                                ],
                              )),
                        ),
                        SizedBox(height: 30.v),
                        CW.termCondition("msg_billing_clearstarttax_com".tr)
                      ],
                    ),
                  ),
                  Form(
                    key: _controller.transerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputFeild(
                            'msg_bank_name'.tr, 'msg_enter_bank_name'.tr,
                            (value) {
                          if (value == null ||
                              value == null ||
                              value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          }
                          return null;
                        }, _controller.bankNameController, [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ]),
                        SizedBox(height: 14.v),
                        _buildInputFeild(
                            'msg_account_name'.tr, 'msg_enter_account_name'.tr,
                            (value) {
                          if (value == null ||
                              value == null ||
                              value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          }
                          return null;
                        }, _controller.bankHolderController, [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ]),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_routing'.tr, 'Enter routing'.tr, (value) {
                          if (value == null ||
                              value == null ||
                              value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          } else if (value.length != 9) {
                            return 'msg_enter_routing'.tr;
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'msg_enter_routing'.tr;
                          }
                          return null;
                        }, _controller.routingController, [
                          LengthLimitingTextInputFormatter(9),
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_account'.tr, 'Enter account number'.tr, (value) {
                          if (value == null ||
                              value == null ||
                              value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'msg_enter_account_number'.tr;
                          } else if (value.length < 8 || value.length > 20) {
                            return 'msg_enter_account_number'.tr;
                          }
                          return null;
                        },
                            _controller.transferAccountController,
                            [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(18)
                            ],
                            textInputType: TextInputType.number),
                        SizedBox(height: 20.v),
                        Text(
                          'msg_billing_address'.tr,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 20.v),
                        _buildInputFeild('msg_street_address1'.tr, 'Enter street address'.tr,
                            (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          }
                          return null;
                        }, _controller.transferAdd1Controller, []),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_street_address2'.tr, 'Enter street address'.tr,
                            (value) {
                          return null;
                        }, _controller.transferAdd2Controller, []),
                        SizedBox(height: 14.v),
                        _buildInputFeild('msg_city'.tr, 'Enter city'.tr, (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "msg_enter_this_field".tr;
                          }
                          return null;
                        }, _controller.transferCityController, [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ]),
                        SizedBox(height: 14.v),
                        _stateDropdown(
                            context, _controller.transferSelectValue.value, 2),
                        SizedBox(height: 14.v),
                        zipDetails(_controller.transferZipController),
                        SizedBox(height: 14.v),
                        _transferEmailAddressSection(),
                        SizedBox(height: 35.v),
                        Obx(() {
                          return _controller.isTranserLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: CustomOutlinedButton(
                                    width: 150.h,
                                    text: "lbl_pay".tr,
                                    buttonStyle: ElevatedButton.styleFrom(),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    onPressed: () => _controller
                                        .clickOnTransferPayButton(context),
                                  ),
                                );
                        }),
                        SizedBox(height: 20.v),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: EdgeInsets.only(left: 10.h, right: 10.h),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "msg_by_clicking_pay".tr,
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer10,
                                children: [
                                  TextSpan(
                                      text: 'Terms and Conditions.',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url =
                                              'https://clearstarttax.com/paymenttermsandconditions/';
                                          if (await canLaunch(url)) {
                                            await launch(url,
                                                forceWebView: true,
                                                enableJavaScript: true);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                      style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 12))
                                ],
                              )),
                        ),
                        SizedBox(height: 30.v),
                        CW.termCondition("msg_billing_clearstarttax_com".tr)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]))
    ]));
  }

  String getCreditCardType(String creditCardNumber) {
    if (RegExp(r"^4[0-9]{0,15}$").hasMatch(creditCardNumber)) {
      _controller.cardType.value = "visa";
      // visa card
      return "visa";
    } else if (RegExp(r"^5(?:[1-5][0-9]{0,14})?$").hasMatch(creditCardNumber)) {
      // master card
      _controller.cardType.value = "master card";
      return "master card";
    } else if (RegExp(r"^3(?:[47][0-9]{0,13})?$").hasMatch(creditCardNumber)) {
      // AExpress card
      _controller.cardType.value = "AExpress card";
      return "AExpress card";
    } else if (RegExp(r"^3(?:(?:0[0-5]?|[68][0-9]?)[0-9]{0,11})?$")
        .hasMatch(creditCardNumber)) {
      _controller.cardType.value = "diner card";
      // diner card
      return "diner card";
    } else if (RegExp(r"^6(?:(?:01{0,2}|5[0-9]{0,2})[0-9]{0,12})?$")
        .hasMatch(creditCardNumber)) {
      _controller.cardType.value = "discover card";
      // discover card
      return "discover card";
    } else if (RegExp(
            r"^(?:2(?:1(?:31?)?)?|1(?:80{0,2})?|3(?:5\d{0,3})?)\d{0,11}$")
        .hasMatch(creditCardNumber)) {
      _controller.cardType.value = "JCB card";
      // JCB card
      return "JCB card";
    } else {
      return "Nothing";
    }
  }



  Widget _stateDropdown(BuildContext context, String value, type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("msg_state".tr, style: theme.textTheme.titleMedium),
        SizedBox(height: 12.v),
        Container(
          height: 42,
          padding: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: appTheme.blueGray100,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "msg_enter_this_field".tr;
              }
              return null;
            },
            alignment: Alignment.center,
            isDense: true,




            menuMaxHeight: 500,
            dropdownColor: Colors.white,
            decoration: InputDecoration(border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 8),
            ),
            icon: const Icon(Icons.arrow_drop_down_outlined),
            elevation: 16,
            isExpanded: true,
            hint: Text('Select'),
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              _controller.setSelectedState(value!, type);
              // homePageController.selectedValue = value!;
              // print(homePageController.selectedValue);
              // homePageController.isSecurityChoosed.value =
              //     true;
            },
            value: value,
            items: _controller.states.map((StateItem state) {
              return DropdownMenuItem<String>(
                value: state.value,
                child: SizedBox(width: 150, child: Text(state.name)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Section Widget

  /// Navigates to the paymentSuccessScreen when the action is triggered.
  onTapPay() {
    Get.toNamed(
      AppRoutes.paymentSuccessScreen,
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  final String value;
  final String label;
  final Widget widget;

  RadioButtonWidget(
      {required this.value, required this.label, required this.widget});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        return Obx(() {
          return Container(
            height: MediaQuery.sizeOf(context).height*0.04,
            child: RadioListTile<String>(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      label,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize:  MediaQuery.sizeOf(context).width*0.035,
                          fontWeight: FontWeight.w500
                          /* 187.5% */
                          ),
                    ),
                  ),
                  Expanded(flex: 1, child: widget)
                ],
              ),
              value: value,
              groupValue: controller.selectedAmount.value,
              onChanged: (String? newValue) {
                if (newValue!.isEmpty || newValue == null) {
                  newValue = controller.paymentController.value.text.toString();
                }

                controller.setSelectedValue(newValue!);
              },
            ),
          );
        });
      },
    );
  }
}
