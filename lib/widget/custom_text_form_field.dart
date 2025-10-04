import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/config/theme/theme_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? enabled;
  final String? hintText;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final TextInputType? keyboardType;
  final bool isPassword;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.isPassword = false,
    this.hintText = '',
    this.prefixIcon,
    this.padding,
    this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: _buildTextFormField(context),
    );
  }

  TextFormField _buildTextFormField(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      style: Theme.of(context).primaryTextTheme.bodyMedium?.semibold,
      cursorColor: Theme.of(context).primaryTextTheme.bodyMedium?.color,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: widget.isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        suffixIcon: _buildSuffixIcon(context),
        contentPadding:
            widget.prefixIcon != null
                ? EdgeInsets.only(right: 16.px, top: 16.px, bottom: 16.px)
                : EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).primaryTextTheme.bodyMedium?.semibold
            .copyWith(color: Theme.of(context).hintColor),
        prefixIcon:
            widget.prefixIcon != null
                ? Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 6.px),
                  child: widget.prefixIcon,
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.px),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.px),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.px),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.px),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.px),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.px,
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (widget.isPassword == false) {
      return null;
    }
    return InkWell(
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      child: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).primaryTextTheme.bodyMedium?.color,
      ),
    );
  }
}
