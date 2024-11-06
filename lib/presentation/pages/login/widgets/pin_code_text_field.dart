part of 'custom_pincode_text_field.dart';

class PinCodeTextField extends StatefulWidget {
  /// The [BuildContext] of the application
  final BuildContext appContext;

  ///Box Shadow for Pincode
  final List<BoxShadow>? boxShadows;

  /// length of how many cells there should be. 3-8 is recommended by me
  final int length;

  /// you already know what it does i guess :P default is false
  final bool obscureText;

  /// Character used for obscuring text if obscureText is true.
  ///
  /// Must not be empty. Single character is recommended.
  ///
  /// Default is ● - 'Black Circle' (U+25CF)
  final String obscuringCharacter;

  /// returns the current typed text in the fields
  final ValueChanged<String>? onChanged;

  /// returns the typed text when all pins are set
  final ValueChanged<String>? onCompleted;

  /// returns the typed text when user presses done/next action on the keyboard
  final ValueChanged<String>? onSubmitted;

  /// the style of the text, default is [ fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold]
  final TextStyle textStyle;

  /// the style of the pasted text, default is [fontWeight: FontWeight.bold] while
  /// [TextStyle.color] is [ThemeData.colorScheme.secondary]
  final TextStyle? pastedTextStyle;

  /// background color for the whole row of pin code fields. Default is [Colors.white]
  final Color backgroundColor;

  /// This defines how the elements in the pin code field align. Default to [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment;

  /// [AnimationType] for the text to appear in the pin code field. Default is [AnimationType.slide]
  final AnimationType animationType;

  /// Duration for the animation. Default is [Duration(milliseconds: 150)]
  final Duration animationDuration;

  /// [Curve] for the animation. Default is [Curves.easeInOut]
  final Curve animationCurve;

  /// [TextInputType] for the pin code fields. default is [TextInputType.visiblePassword]
  final TextInputType keyboardType;

  /// If the pin code field should be autofocused or not. Default is false
  final bool autoFocus;

  /// Should pass a [FocusNode] to manage it from the parent
  final FocusNode? focusNode;

  /// A list of [TextInputFormatter] that goes to the TextField
  final List<TextInputFormatter> inputFormatters;

  /// Enable or disable the Field. Default is true
  final bool enabled;

  /// [TextEditingController] to control the text manually. Sets a default [TextEditingController()] object if none given
  final TextEditingController? controller;

  /// Enabled Color fill for individual pin fields, default is false
  final bool enableActiveFill;

  /// Auto dismiss the keyboard upon inputting the value for the last field. Default is true
  final bool autoDismissKeyboard;

  /// Auto dispose the [controller] and [FocusNode] upon the destruction of widget from the widget tree. Default is true
  final bool autoDisposeControllers;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  /// Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  /// - Copied from 'https://api.flutter.dev/flutter/services/TextCapitalization-class.html'
  /// Default is [TextCapitalization.none]
  final TextCapitalization textCapitalization;

  final TextInputAction textInputAction;

  /// Triggers the error animation
  final StreamController<ErrorAnimationType>? errorAnimationController;

  /// Callback method to validate if text can be pasted. This is helpful when we need to validate text before pasting.
  /// e.g. validate if text is number. Default will be pasted as received.
  final bool Function(String text)? beforeTextPaste;

  /// Method for detecting a pin_code form tap
  /// work with all form windows
  final Function? onTap;

  /// Theme for the pin cells. Read more [PinTheme]
  final PinTheme? pinTheme;

  /// Brightness dark or light choices for iOS keyboard.
  final Brightness keyboardAppearance;

  /// Validator for the [TextFormField]
  final FormFieldValidator<String>? validator;

  /// An optional method to call with the final value when the form is saved via
  /// [FormState.save].
  final FormFieldSetter<String>? onSaved;

  /// enables auto validation for the [TextFormField]
  /// Default is false
  final AutovalidateMode autovalidateMode;

  /// The vertical padding from the [PinCodeTextField] to the error text
  /// Default is 16.
  final double errorTextSpace;

  /// Enables pin autofill for TextFormField.
  /// Default is true
  final bool enablePinAutofill;

  /// Error animation duration
  final int errorAnimationDuration;

  /// Whether to show cursor or not
  final bool showCursor;

  /// The color of the cursor, default to Theme.of(context).accentColor
  final Color? cursorColor;

  /// width of the cursor, default to 2
  final double cursorWidth;

  /// Height of the cursor, default to FontSize + 8;
  final double? cursorHeight;

  PinCodeTextField({
    super.key,
    required this.appContext,
    required this.length,
    this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.onChanged,
    this.onCompleted,
    this.backgroundColor = Colors.white,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.animationType = AnimationType.slide,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    this.pastedTextStyle,
    this.enableActiveFill = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.onSubmitted,
    this.errorAnimationController,
    this.beforeTextPaste,
    this.pinTheme,
    this.keyboardAppearance = Brightness.light,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorTextSpace = 16,
    this.enablePinAutofill = true,
    this.errorAnimationDuration = 500,
    this.boxShadows,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
  }) : assert(obscuringCharacter.isNotEmpty, 'Obscuring character must not be empty');

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> with TickerProviderStateMixin {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;
  late BorderRadius borderRadius;

  // AnimationController for the error animation
  late AnimationController _controller;

  late AnimationController _cursorController;

  StreamSubscription<ErrorAnimationType>? _errorAnimationSubscription;

  // Animation for the error animation
  late Animation<Offset> _offsetAnimation;

  late Animation<double> _cursorAnimation;

  PinTheme get _pinTheme => widget.pinTheme ?? PinTheme();

  @override
  void initState() {
    super.initState();

    _checkForInvalidValues();
    _assignController();
    if (_pinTheme.shape != PinCodeFieldShape.circle && _pinTheme.shape != PinCodeFieldShape.underline) {
      borderRadius = _pinTheme.borderRadius;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });

    _inputList = List<String>.filled(widget.length, '');

    _cursorController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _cursorController,
        curve: Curves.easeIn,
      ),
    );
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.errorAnimationDuration),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );
    if (widget.showCursor) {
      _cursorController.repeat();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    if (widget.errorAnimationController != null) {
      _errorAnimationSubscription = widget.errorAnimationController!.stream.listen((errorAnimation) {
        if (errorAnimation == ErrorAnimationType.shake) {
          _controller.forward();
        }
      });
    }
  }

  void _checkForInvalidValues() {
    assert(widget.length > 0, 'Length must be at least 1');
    assert(_pinTheme.fieldHeight > 0, 'Height must be greater than 0');
    assert(_pinTheme.fieldWidth > 0, 'Width must be greater than 0');
    assert(_pinTheme.borderWidth >= 0, 'Border must be at least 0');
    if (widget.showCursor) {}
  }

  void _assignController() {
    if (widget.controller != null) {
      _textEditingController = widget.controller!;
    } else {
      _textEditingController = TextEditingController();
    }
    _textEditingController.addListener(() {
      var currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onCompleted != null) {
            if (currentText.length > widget.length) {
              currentText = currentText.substring(0, widget.length);
            }
            Future.delayed(
              const Duration(milliseconds: 300),
              () => widget.onCompleted != null ? widget.onCompleted!(currentText) : {},
            );
          }

          if (widget.autoDismissKeyboard) {
            _focusNode.unfocus();
          }
        }
        widget.onChanged?.call(currentText);
      }

      _setTextToInput(currentText);
    });
  }

  @override
  void dispose() {
    if (widget.autoDisposeControllers) {
      _textEditingController.dispose();
      _focusNode.dispose();
    }
    _errorAnimationSubscription?.cancel();
    _cursorController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledColor;
    }
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return _pinTheme.selectedColor;
    } else if (_selectedIndex > index) {
      return _pinTheme.activeColor;
    }
    return _pinTheme.inactiveColor;
  }

  Color _getFillColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledColor;
    }
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return _pinTheme.selectedFillColor;
    } else if (_selectedIndex > index) {
      return _pinTheme.activeFillColor;
    }
    return _pinTheme.inactiveFillColor;
  }

  Widget buildChild(int index) {
    if (((_selectedIndex == index) || (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus &&
        widget.showCursor) {
      final cursorColor = widget.cursorColor ??
          Theme.of(widget.appContext).textSelectionTheme.cursorColor ??
          Theme.of(context).colorScheme.secondary;
      final cursorHeight = widget.cursorHeight ?? (widget.textStyle.fontSize ?? 0) + 8;

      if (_selectedIndex == index + 1 && index + 1 == widget.length) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: (widget.textStyle.fontSize ?? 0) / 1.5),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: CursorPainter(
                      cursorColor: cursorColor,
                      cursorWidth: widget.cursorWidth,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              widget.obscureText && _inputList[index].isNotEmpty ? widget.obscuringCharacter : _inputList[index],
              key: ValueKey(_inputList[index]),
              style: widget.textStyle,
            ),
          ],
        );
      } else {
        return Center(
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, cursorHeight),
              painter: CursorPainter(
                cursorColor: cursorColor,
                cursorWidth: widget.cursorWidth,
              ),
            ),
          ),
        );
      }
    }
    return Text(
      widget.obscureText && _inputList[index].isNotEmpty ? widget.obscuringCharacter : _inputList[index],
      key: ValueKey(_inputList[index]),
      style: widget.textStyle,
    );
  }

  @override
  Widget build(BuildContext context) => SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: (widget.pinTheme?.fieldHeight ?? PinTheme().fieldHeight) + widget.errorTextSpace,
          color: widget.backgroundColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AbsorbPointer(
                child: AutofillGroup(
                  child: TextFormField(
                    key: const Key('pinInputTextField'),
                    textInputAction: widget.textInputAction,
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    enabled: widget.enabled,
                    autofocus: widget.autoFocus,
                    autocorrect: false,
                    keyboardType: widget.keyboardType,
                    keyboardAppearance: widget.keyboardAppearance,
                    textCapitalization: widget.textCapitalization,
                    validator: widget.validator,
                    onSaved: widget.onSaved,
                    autovalidateMode: widget.autovalidateMode,
                    inputFormatters: [
                      ...widget.inputFormatters,
                      LengthLimitingTextInputFormatter(widget.length),
                    ],
                    onFieldSubmitted: widget.onSubmitted,
                    enableInteractiveSelection: false,
                    showCursor: true,
                    cursorColor: widget.backgroundColor,
                    cursorWidth: 0.01,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      fillColor: widget.backgroundColor,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.transparent,
                      height: .01,
                      fontSize: 0.01,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onTap != null) {
                      // ignore: avoid_dynamic_calls
                      (widget.onTap!).call();
                    }
                    _onFocus();
                  },
                  child: Row(
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: _generateFields(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  List<Widget> _generateFields() {
    final result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(
        AnimatedContainer(
          curve: widget.animationCurve,
          duration: widget.animationDuration,
          width: _pinTheme.fieldWidth,
          height: _pinTheme.fieldHeight,
          decoration: BoxDecoration(
            color: widget.enableActiveFill ? _getFillColorFromIndex(i) : Colors.transparent,
            boxShadow: widget.boxShadows,
            shape: _pinTheme.shape == PinCodeFieldShape.circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: borderRadius,
            border: _pinTheme.shape == PinCodeFieldShape.underline
                ? Border(
                    bottom: BorderSide(
                      color: _getColorFromIndex(i),
                      width: _pinTheme.borderWidth,
                    ),
                  )
                : _pinTheme.borderWidth == 0
                    ? null
                    : Border.all(
                        color: _getColorFromIndex(i),
                        width: _pinTheme.borderWidth,
                      ),
          ),
          child: Center(
            child: AnimatedSwitcher(
              switchInCurve: widget.animationCurve,
              switchOutCurve: widget.animationCurve,
              duration: widget.animationDuration,
              transitionBuilder: (child, animation) {
                if (widget.animationType == AnimationType.scale) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                } else if (widget.animationType == AnimationType.fade) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                } else if (widget.animationType == AnimationType.none) {
                  return child;
                } else {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, .5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                }
              },
              child: buildChild(i),
            ),
          ),
        ),
      );
    }
    return result;
  }

  void _onFocus() {
    if (_focusNode.hasFocus && MediaQuery.viewInsetsOf(widget.appContext).bottom == 0) {
      _focusNode.unfocus();
      Future.delayed(const Duration(microseconds: 1), () => _focusNode.requestFocus());
    } else {
      _focusNode.requestFocus();
    }
  }

  void _setTextToInput(String data) {
    final replaceInputList = List<String>.filled(widget.length, '');

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : '';
    }

    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }
}

enum AnimationType { scale, slide, fade, none }

enum PinCodeFieldShape { box, underline, circle }

enum ErrorAnimationType { shake }

class CursorPainter extends CustomPainter {
  final Color cursorColor;
  final double cursorWidth;

  CursorPainter({this.cursorColor = Colors.black, this.cursorWidth = 2});
  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset.zero;
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PinTheme {
  /// Colors of the input fields which have inputs. Default is [const Color.fromRGBO(61, 193, 78, 1.0)]
  final Color activeColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs. Default is [const Color.fromRGBO(242, 111, 102, 1.0)]
  final Color inactiveColor;

  /// Colors of the input fields if the [PinCodeTextField] is disabled. Default is [Colors.grey]
  final Color disabledColor;

  /// Colors of the input fields which have inputs. Default is [const Color.fromRGBO(61, 193, 78, 1.0)]
  final Color activeFillColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedFillColor;

  /// Colors of the input fields which don't have inputs. Default is [const Color.fromRGBO(242, 111, 102, 1.0)]
  final Color inactiveFillColor;

  /// Border radius of each pin code field
  final BorderRadius borderRadius;

  /// height for the pin code field. default is [50.0]
  final double fieldHeight;

  /// width for the pin code field. default is [40.0]
  final double fieldWidth;

  /// Border width for the each input fields. Default is [2.0]
  final double borderWidth;

  /// this defines the shape of the input fields. Default is underlined
  final PinCodeFieldShape shape;

  PinTheme({
    BorderRadius? borderRadius,
    double? fieldHeight,
    double? fieldWidth,
    double? borderWidth,
    PinCodeFieldShape? shape,
    Color? activeBorderColor,
    Color? selectedBorderColor,
    Color? unselectedBorderColor,
    Color? disabledBorderColor,
    Color? activeFillColor,
    Color? selectedFillColor,
    Color? unselectedFillColor,
  })  : activeColor = activeBorderColor ?? const Color.fromRGBO(231, 231, 239, 1),
        selectedColor = selectedBorderColor ?? GlobalColors.brown,
        inactiveColor = unselectedBorderColor ?? const Color.fromRGBO(231, 231, 239, 1),
        disabledColor = disabledBorderColor ?? const Color.fromRGBO(231, 231, 239, 1),
        activeFillColor = activeFillColor ?? GlobalColors.surface,
        selectedFillColor = selectedFillColor ?? GlobalColors.surface,
        inactiveFillColor = unselectedFillColor ?? GlobalColors.surface,
        borderRadius = borderRadius ?? BorderRadius.zero,
        fieldHeight = fieldHeight ?? 50,
        fieldWidth = fieldWidth ?? 40,
        borderWidth = borderWidth ?? 1,
        shape = shape ?? PinCodeFieldShape.underline;
}
