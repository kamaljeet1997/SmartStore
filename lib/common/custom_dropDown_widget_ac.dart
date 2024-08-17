
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api/utils/utils.dart';
import 'appColors.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  final ValueChanged<T?>? onChanged;
  final List<T>? dataList;
  final double? fontsize;
  final Color? textcolor;
  final String? fontFamily;
  final T? value;
  final String? hinttext;
  final Widget? icon;
  final TextStyle? hintStyle;
  final Widget? lable;
  final EdgeInsetsGeometry? padding;
  final String Function(T data) item;

  const CustomDropDownWidget(
      {Key? key,
      required this.dataList,
      required this.item,
      required this.onChanged,
      this.textcolor,
      this.fontFamily,
      this.fontsize,
      this.hinttext,
      this.padding,
      this.icon,
      this.hintStyle,
      this.lable,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Utils.commonDecoration,
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width / 55,
            right: Get.width / 55,
            top: Get.height / 90,
            bottom: Get.height / 90),
        child: DropdownButton<T>(
          isExpanded: true,
          isDense: true,
          dropdownColor: AppColors.white,
          hint: Text(
            hinttext.toString(),
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: hintStyle,
          ),
          underline: Container(),
          icon: icon,
          onChanged: onChanged,
          items: dataList
                  ?.map<DropdownMenuItem<T>>(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        item(e),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: Utils.textmedium12dsp(),
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
