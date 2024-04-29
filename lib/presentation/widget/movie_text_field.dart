import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';

enum MovieTextFieldType { text, password, search }

class MovieTextField extends StatefulWidget {
  const MovieTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.onSaved,
    this.type = MovieTextFieldType.text,
    this.isEditable = true,
    this.isRequired = false,
    this.initialValue,
  })  : onTap = null,
        onClear = null;

  const MovieTextField.search({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.onSaved,
    this.onTap,
    this.onClear,
    this.isEditable = true,
    this.initialValue,
  })  : label = "",
        isRequired = false,
        type = MovieTextFieldType.search;

  final TextEditingController controller;
  final String placeholder;
  final String label;
  final MovieTextFieldType type;
  final void Function(String? value) onSaved;
  final void Function()? onTap;
  final void Function()? onClear;
  final bool isEditable;
  final bool isRequired;
  final String? initialValue;

  @override
  State<MovieTextField> createState() => _MovieTextFieldState();
}

class _MovieTextFieldState extends State<MovieTextField> {
  final _focusNode = FocusNode();
  var isFocus = false;
  var isError = false;
  var isObscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocus = _focusNode.hasFocus;
    });
  }

  Widget _renderSearchField(Color bgColor, Widget? suffixIcon) {
    final borderDecoration = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: bgColor),
      borderRadius: BorderRadius.circular(24),
    );

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        hintText: widget.placeholder,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.placeholder),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: borderDecoration,
        focusedBorder: borderDecoration,
        disabledBorder: borderDecoration,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.black,
          size: 20,
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.labelSmall,
      onFieldSubmitted: widget.onSaved,
      onTap: widget.onTap,
      readOnly: !widget.isEditable,
    );
  }

  Widget _renderTextField(Color bgColor, Widget? suffixIcon) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      obscureText: (widget.type == MovieTextFieldType.password) ? isObscure : false,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        hintText: widget.placeholder,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.placeholder),
        filled: true,
        fillColor: bgColor,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: bgColor),
          borderRadius: BorderRadius.circular(4),
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.labelSmall,
      validator: (value) {
        final isValid = inputValidator(widget.type, value, widget.label);

        setState(() {
          isError = isValid != null;
        });

        return isValid;
      },
      onSaved: widget.onSaved,
      readOnly: !widget.isEditable,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = (isFocus) ? PrimaryColor.light : OtherColor.lineDivider;
    Widget? suffixIcon;

    if (widget.type == MovieTextFieldType.password) {
      suffixIcon = IconButton(
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: Icon(
          (isObscure) ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          size: 20,
          color: TextColor.secondary,
        ),
      );
    } else if (isFocus) {
      suffixIcon = IconButton(
        onPressed: () {
          if (widget.onClear != null) {
            widget.onClear!();
          }
          FocusScope.of(context).unfocus();
          widget.controller.clear();
        },
        icon: Icon(
          Icons.cancel_rounded,
          size: 20,
          color: TextColor.secondary,
        ),
      );
    }

    if (isError) {
      bgColor = Theme.of(context).colorScheme.errorContainer;
      suffixIcon = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.type != MovieTextFieldType.search)
            ? Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: widget.label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.label)),
                        (widget.isRequired) ? TextSpan(text: "*", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red)) : const TextSpan(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              )
            : const SizedBox(),
        (widget.type == MovieTextFieldType.search) ? _renderSearchField(bgColor, suffixIcon) : _renderTextField(bgColor, suffixIcon),
      ],
    );
  }
}

String? inputValidator(MovieTextFieldType type, String? value, String label) {
  if (value == null || value.trim().isEmpty) {
    return "$label is required";
  }

  switch (type) {
    case MovieTextFieldType.text:
      break;
    case MovieTextFieldType.password:
      if (value.length < 6 || value.length > 12) {
        return "$label must between 6 and 12 characters";
      }
      break;
    case MovieTextFieldType.search:
      break;
  }

  return null;
}
