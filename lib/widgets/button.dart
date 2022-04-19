import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final String? text;
  final EdgeInsets? padding;
  final bool loading;
  final Color? background;
  final Color? foreground;
  final Widget? icon;
  final TextStyle? textStyle;
  const AppButton(
      {Key? key,
      this.onPressed,
      this.child,
      this.text,
      this.padding,
      this.loading = false,
      this.background,
      this.icon,
      this.textStyle,
      this.foreground})
      : assert(child != null || text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        elevation: 0.0,
        padding: padding,
        primary: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)));
    return ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: style,
        child: loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              )
            : child ??
                (icon != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          icon!,
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                text!.toUpperCase(),
                                style: textStyle != null
                                    ? Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.merge(textStyle)
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4)
                        ],
                      )
                    : Text(
                        text!.toUpperCase(),
                        style: textStyle != null
                            ? Theme.of(context)
                                .textTheme
                                .button
                                ?.merge(textStyle)
                            : null,
                      )));
  }
}
