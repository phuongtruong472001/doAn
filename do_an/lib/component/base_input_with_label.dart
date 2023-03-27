import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/component/input_text_form_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Enum/input_formatter_enum.dart';
import '../base/dimen.dart';

class InputTextWithLabel extends StatelessWidget {
  final BuildInputText buildInputText;
  final String label;
  final String? labelRequired;
  final TextStyle? textStyle;
  final double? padding;
  final EdgeInsetsGeometry? paddingText;

  const InputTextWithLabel({
    Key? key,
    required this.label,
    required this.buildInputText,
    this.labelRequired,
    this.textStyle,
    this.padding,
    this.paddingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: paddingText ?? EdgeInsets.zero,
            child: Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    label,
                    style: textStyle ?? Get.textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AutoSizeText(
                  labelRequired ?? "",
                  style: Get.textTheme.bodyText1?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          buildInputText,
        ],
      ),
    );
  }
}

class BuildInputText extends StatefulWidget {
  final InputTextModel inputTextFormModel;

  const BuildInputText(this.inputTextFormModel, {Key? key}) : super(key: key);

  @override
  _BuildInputTextState createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildInputText> {
  final RxBool _isShowButtonClear = false.obs;
  final RxBool _showPassword = false.obs;

  @override
  void initState() {
    widget.inputTextFormModel.controller.addListener(() {
      if (widget.inputTextFormModel.controller.text.isNotEmpty) {
        _isShowButtonClear.value = true;
      }
    });
    _showPassword.value = widget.inputTextFormModel.obscureText;
    super.initState();
  }

  List<TextInputFormatter> getFormatters() {
    switch (widget.inputTextFormModel.inputFormatters) {
      // case InputFormatterEnum.digitsOnly:
      //   return [
      //     FilteringTextInputFormatter.digitsOnly,
      //     LengthLimitingTextInputFormatter(
      //         widget.inputTextFormModel.maxLengthInputForm),
      //   ];
      // case InputFormatterEnum.taxCode:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      //     MaskedInputFormatter('##########-###')
      //   ];
      case InputFormatterEnum.textOnly:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_\.]')),
        ];
      // case InputFormatterEnum.currency:
      //   return [
      //     NumericTextFormatter(),
      //   ];

      // case InputFormatterEnum.negativeNumber:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      //   ];

      // case InputFormatterEnum.decimalNumber:
      //   return [
      //     FilteringTextInputFormatter.allow(
      //         RegExp('[0-9${getDefaultFormatCurrency()}]')),
      //   ];

      // case InputFormatterEnum.identity:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      //     MaskedInputFormatter('############')
      //   ];
      // case InputFormatterEnum.phoneNumber:
      //   return [
      //     FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
      //     MaskedInputFormatter('##############')
      //   ];
      default:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_\.]')),
        ];
    }
  }

  Widget? _suffixIcon() {
    if (widget.inputTextFormModel.suffixIcon != null) {
      return widget.inputTextFormModel.suffixIcon;
    }
    if (!_isShowButtonClear.value || widget.inputTextFormModel.isReadOnly) {
      return null;
    }
    return widget.inputTextFormModel.obscureText
        ? GestureDetector(
            onTap: () {
              _showPassword.toggle();
            },
            child: Icon(
              _showPassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.remove_red_eye_outlined,
              color: widget.inputTextFormModel.suffixColor ?? Colors.black,
            ),
          )
        : Visibility(
            visible: _isShowButtonClear.value &&
                !widget.inputTextFormModel.isReadOnly,
            child: GestureDetector(
              onTap: () {
                widget.inputTextFormModel.controller.clear();
                widget.inputTextFormModel.onChanged?.call('');
                _isShowButtonClear.value = false;
              },
              child: Icon(
                Icons.clear,
                color: widget.inputTextFormModel.suffixColor ?? Colors.black,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        maxLines: widget.inputTextFormModel.maxLines,
        inputFormatters: getFormatters(),
        validator: widget.inputTextFormModel.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) {
          if (!_isShowButtonClear.value || v.isEmpty) {
            _isShowButtonClear.value = v.isNotEmpty;
          }
          widget.inputTextFormModel.onChanged?.call(v);
        },
        textInputAction: widget.inputTextFormModel.iconNextTextInputAction,
        style: widget.inputTextFormModel.style ??
            Get.textTheme.bodyText1?.copyWith(
                fontSize: widget.inputTextFormModel.textSize ?? sizeTextSmall,
                color: widget.inputTextFormModel.textColor ?? Colors.black),
        controller: widget.inputTextFormModel.controller,
        obscureText: _showPassword.value,
        onTap: widget.inputTextFormModel.onTap,
        enabled: widget.inputTextFormModel.enable,
        autofocus: widget.inputTextFormModel.autoFocus,
        focusNode: widget.inputTextFormModel.currentNode,
        scrollPadding: const EdgeInsets.only(
          bottom: defaultPadding,
        ),
        keyboardType: widget.inputTextFormModel.textInputType,
        readOnly: widget.inputTextFormModel.isReadOnly,
        maxLength: widget.inputTextFormModel.maxLengthInputForm,
        textAlign: widget.inputTextFormModel.textAlign ?? TextAlign.start,
        onFieldSubmitted: (v) {
          if (widget.inputTextFormModel.iconNextTextInputAction.toString() ==
              TextInputAction.next.toString()) {
            FocusScope.of(context)
                .requestFocus(widget.inputTextFormModel.nextNode);

            widget.inputTextFormModel.onNext?.call(v);
          } else {
            widget.inputTextFormModel.submitFunc?.call(v);
          }
        },
        decoration: InputDecoration(
            counterText:
                widget.inputTextFormModel.isShowCounterText ? null : '',
            filled: widget.inputTextFormModel.filled,
            fillColor:
                widget.inputTextFormModel.fillColor ?? kPrimaryLightColor,
            hintStyle: TextStyle(
              fontSize: widget.inputTextFormModel.hintTextSize ?? sizeTextSmall,
              color: widget.inputTextFormModel.hintTextColor ?? kSecondaryColor,
            ),
            hintText: widget.inputTextFormModel.hintText,
            labelText: widget.inputTextFormModel.labelText,
            labelStyle: Get.textTheme.bodyText2,
            errorStyle: TextStyle(
              color: widget.inputTextFormModel.errorTextColor ?? Colors.red,
            ),
            prefixIcon: widget.inputTextFormModel.iconLeading != null
                ? Icon(
                    widget.inputTextFormModel.iconLeading,
                    color: widget.inputTextFormModel.prefixIconColor ??
                        Colors.black,
                    size: defaultSizeIcon,
                  )
                : null,
            prefixStyle: const TextStyle(
                color: Colors.red, backgroundColor: Colors.black),
            border: widget.inputTextFormModel.border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        widget.inputTextFormModel.borderRadius),
                    borderSide: BorderSide.none),
            contentPadding: widget.inputTextFormModel.contentPadding ??
                const EdgeInsets.all(defaultPadding),
            suffixIcon: _suffixIcon(),
            helperText: widget.inputTextFormModel.helperText,
            helperStyle: widget.inputTextFormModel.helperStyle,
            helperMaxLines: widget.inputTextFormModel.helperMaxLines),
      ),
    );
  }
}
