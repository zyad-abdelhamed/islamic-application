import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/contact_us_list_tile_widget.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ContactUsTabView extends StatelessWidget {
  const ContactUsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5.0,
      children: [
        Text(
          "If you have any other questions or\nneed further assistance, please contact us at",
         // style: TextStyles.semiBold18(context),
        ),
        ...List.generate(
            2,
            (index) => contactUsListTileWidget(
                icon: contactUsListTilesIcons[index],
                title: contactUsListTilesTitles[index],
                context: context))
      ],
    );
  }
}

const List<String> contactUsListTilesTitles = <String>[
  "Customer service",
  "Whatsapp"
];
const List<IconData> contactUsListTilesIcons = <IconData>[
  Icons.phone,
  CupertinoIcons.phone
];
