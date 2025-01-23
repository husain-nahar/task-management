import 'exports.dart';

// CUSTOM INKWELL
Widget customInkWel({
  Widget? child,
  required void Function()? onTap,
}) {
  return Material(
    color: transperentColor,
    child: InkWell(
      onTap: onTap,
      child: child,
    ),
  );
}

Gap gap([double gap = 15]) => Gap(gap);

// CUSTOM PHONE TEXT FIELD
class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField({
    super.key,
    required String? hintText,
    required TextEditingController controler,
  })  : _hintText = hintText,
        _controler = controler;

  final String? _hintText;
  final TextEditingController _controler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultHeightForButonTextField,
      child: Center(
        child: AutoSizeTextField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: _controler,
          keyboardType: TextInputType.phone,
          style: TextStyle(),
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            labelStyle: TextStyle(),
            hintStyle: TextStyle(),
            hintText: _hintText,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PhoneWithCodeTextField extends StatelessWidget {
  const PhoneWithCodeTextField({
    super.key,
  });

  Widget customCountryWidget(
    BuildContext context,
  ) {
    String? authenticationControlerCountryCode = (validateBoolean(
            authControler.getSelectedCountry?.countryCode.isNotEmpty))
        ? ("${authControler.getSelectedCountry?.flagEmoji} ${authControler.getSelectedCountry?.countryCode} ${authControler.getSelectedCountry?.phoneCode}")
        : selectCountryStr;

    return Center(
      child: Text(
        authenticationControlerCountryCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: defaultHeightForButonTextField,
      decoration: BoxDecoration(
        borderRadius: borderRadius12,
        border: Border.all(
          color: blackColor,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: customInkWel(
              child: Container(
                color: transperentColor,
                child: Column(
                  children: [
                    Expanded(
                      child: GetX<AuthControler>(
                        builder: (_) => customCountryWidget(context),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                printT("SHOW PRESED");
                showCountryPicker(
                  countryListTheme: CountryListThemeData(
                    textStyle: TextStyle(),
                  ),
                  context: context,
                  favorite: ["KW", "IN"],
                  onSelect: (Country selectedCountry) {
                    printT("COUNTRY SELECTED IS: $selectedCountry");
                    authControler.setCountry = selectedCountry;
                  },
                );
              },
            ),
          ),
          Container(
            width: 0.5,
            color: blackColor,
            height: double.infinity,
          ),
          Expanded(
            flex: 5,
            child: CustomPhoneTextField(
              hintText: phoneNumberStr,
              controler: authControler.getPhoneTextEditingControler,
            ),
          ),
        ],
      ),
    );
  }
}

TapRegion keyboardDismisWidget(
  BuildContext context, {
  required Widget child,
}) {
  return TapRegion(
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    child: child,
  );
}

// CUSTOM BUTTON USING ELEVATED BUTTON
class CustomBtn extends StatelessWidget {
  const CustomBtn({
    String? text,
    IconData? iconData,
    super.key,
    Color? explicitBgColor,
    // Color? explicitTextColor,
    bool transperentBg = false,
    double? explicitHeight,
    required VoidCallback? onPresed,
  })  : _text = text,
        _onPresed = onPresed,
        _explicitBgColor = explicitBgColor,
        _transperentBg = transperentBg,
        _explicitHeight = explicitHeight;

  final String? _text;
  final VoidCallback? _onPresed;
  final Color? _explicitBgColor;
  final bool _transperentBg;
  final double? _explicitHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _explicitHeight ?? defaultHeightForButonTextField,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              _transperentBg ? transperentColor : _explicitBgColor),
          elevation: WidgetStatePropertyAll(_transperentBg ? 0 : 5),
        ),
        onPressed: _onPresed,
        child: Text(
          _text ?? "",
          style: TextStyle(color: whiteColor),
        ),
      ),
    );
  }
}

// RICH TEXT
Widget customRichText(
  BuildContext context, {
  String? firstStr,
  String? secondStr,
  Color? explicitColor,
}) =>
    RichText(
      text: TextSpan(
        text: "$firstStr: ",
        style: TextStyle(
          color: explicitColor,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: secondStr,
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );

// ONLINE OFFLINE TOGGLE
Widget onlineOflineSectionChildren({
  isForInitial = false,
}) {
  return isForInitial
      ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.yellowAccent,
              child: GetX<ConectivityControler>(builder: (_) {
                return Text(
                  "  ${((conectivityControler.noInternet) ? youAreNotConectedToInternet : youAreConectedToInternet)}  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (conectivityControler.noInternet)
                          ? redColor
                          : greenColor),
                );
              }),
            ),
            SizedBox(
              width: defaultPading,
              height: defaultPading,
            ),
          ],
        )
      : Column(
          children: [
            Container(
              color: Colors.yellowAccent,
              child: GetX<ConectivityControler>(builder: (_) {
                return Text(
                  "  ${((conectivityControler.noInternet) ? youAreNotConectedToInternet : youAreConectedToInternet)}  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (conectivityControler.noInternet)
                          ? redColor
                          : greenColor),
                );
              }),
            ),
            SizedBox(
              width: defaultPading,
              height: defaultPading,
            ),
          ],
        );
}
