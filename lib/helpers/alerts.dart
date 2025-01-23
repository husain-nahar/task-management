import 'exports.dart';

// SHOW LOADING VIA GETX
void showLoader() {
  hideLoader();

  Get.dialog(
    Center(
      child: CircularProgressIndicator(
        color: blackColor,
      ),
    ),
    barrierDismissible: false,
  );
}

// DISMISS LOADING VIA GETX
void hideLoader() {
  if (validateBoolean(Get.isDialogOpen)) {
    GetXRouterClas.dismisControler;
  }
}

// SHOW ALERT AS INFO WITH/WITHOUT TIMER
void showInfoAlert(
  String? withText, {
  bool autoDismis = false,
}) async {
  hideLoader();
  if (validateBoolean(Get.isDialogOpen)) {
    printT("DIALOG OPEN");
  }
  printT("SHOW ALERT DIALOG MESAGE: $withText");

  Get.dialog(
    Scaffold(
      backgroundColor: transperentColor,
      body: customInkWel(
        onTap: () => hideLoader(),
        child: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          return Center(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                width: constraints.maxWidth / 2.0,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    radius12,
                  ),
                ),
                child: Column(
                  children: [
                    gap(),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          withText ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 10,
                        ),
                      ),
                    ),
                    gap(),
                    customInkWel(
                      onTap: () {
                        hideLoader();
                      },
                      child: Container(
                        height: defaultHeightForButonTextField,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: radius12,
                            bottomRight: radius12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            style: TextStyle(
                              color: whiteColor,
                            ),
                            okStr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );

  if (autoDismis) {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    hideLoader();
  }
}

// SHOW OK ALERT WITH ACTION
void showCustomAlert({
  required String? withText,
  IconData? withIcon,
  bool isNegative = false,
  String? btnText,
  void Function()? btnPresed,
  void Function()? cancelPresed,
  bool autoDismis = false,
  Color? explicitColor,
}) async {
  hideLoader();

  Widget customText = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Text(
      withText ?? "",
      textAlign: TextAlign.center,
      maxLines: 10,
    ),
  );

  Get.dialog(
    Scaffold(
      backgroundColor: transperentColor,
      body: LayoutBuilder(builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        return Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              width: constraints.maxWidth / 2.0,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  radius12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customInkWel(
                        onTap: () {
                          hideLoader();
                          cancelPresed?.call();
                        },
                        child: Container(
                          height: defaultHeightForButonTextField,
                          width: defaultHeightForButonTextField,
                          decoration: BoxDecoration(
                              color: explicitColor ??
                                  (isNegative ? redColor : greenColor),
                              borderRadius: BorderRadius.only(
                                topRight: radius12,
                                topLeft: radius0,
                                bottomLeft: radius12,
                                bottomRight: radius0,
                              )),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              onPressed: () {
                                hideLoader();
                                cancelPresed?.call();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  gap(),
                  customText,
                  gap(),
                  customInkWel(
                    onTap: () {
                      hideLoader();

                      btnPresed?.call();
                    },
                    child: Container(
                      height: defaultHeightForButonTextField,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: explicitColor ??
                              (isNegative ? redColor : greenColor),
                          borderRadius: BorderRadius.only(
                            bottomLeft: radius12,
                            bottomRight: radius12,
                          )),
                      child: Center(
                        child: Text(
                          btnText ?? yesStr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
    barrierDismissible: false,
  );

  if (autoDismis) {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    hideLoader();
  }
}
