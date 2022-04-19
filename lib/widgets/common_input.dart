import 'package:flutter/material.dart';
import 'package:study/utils/meta/text.dart';

///
/// TextLabel
///

class CommonInputLabel extends StatelessWidget {
  final String label;
  final bool required;
  final TextStyle? style;
  const CommonInputLabel(
      {Key? key, required this.label, this.required = false, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label + (required ? "*" : ""),
      style: style ?? Theme.of(context).inputDecorationTheme.labelStyle,
    );
  }
}

///
/// TexFormField
///
class CommonInputField extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final String? helperText;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final Function()? onTap;
  final bool enabled;
  final TextInputAction? textInputAction;
  final bool required;
  final bool readOnly;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final Brightness? keyboardAppearance;
  final bool autofocus;
  final String? initialValue;
  final int? maxLength;
  final InputDecoration? inputDecoration;
  const CommonInputField({
    Key? key,
    this.label,
    this.labelStyle,
    this.prefix,
    this.suffix,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.enabled = true,
    this.textInputAction,
    this.required = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.contentPadding,
    this.focusNode,
    this.keyboardAppearance,
    this.autofocus = false,
    this.initialValue,
    this.maxLength,
    this.inputDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            child: CommonInputLabel(
              label: label!,
              required: required,
              style: labelStyle,
            ),
          ),
        Opacity(
          opacity: enabled ? 1.0 : 0.4,
          child: TextFormField(
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            obscureText: obscureText,
            focusNode: focusNode,
            autofocus: autofocus,
            validator: (val) {
              bool isEmpty = val?.isEmpty ?? false;
              if (required && isEmpty) {
                return MetaText.of(context).required;
              }
              if (validator != null) {
                return validator!(val);
              }
              return null;
            },
            initialValue: initialValue,
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            onTap: onTap,
            maxLines: maxLines,
            readOnly: readOnly,
            enabled: enabled,
            maxLength: maxLength,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.normal),
            keyboardAppearance:
                keyboardAppearance ?? Theme.of(context).brightness,
            decoration: inputDecoration ??
                InputDecoration(
                    helperText: helperText,
                    contentPadding: contentPadding ??
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    prefixIcon: prefix != null
                        ? SizedBox(
                            height: 32,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [prefix!],
                            ),
                          )
                        : null,
                    suffixIcon: suffix != null
                        ? SizedBox(
                            height: 32,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [suffix!],
                            ),
                          )
                        : null,
                    hintText: hintText,
                    helperMaxLines: 3),
          ),
        ),
      ],
    );
  }
}
