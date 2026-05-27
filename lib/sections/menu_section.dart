import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';
import '../services/menu_service.dart';
import 'contact_section.dart' show launchWhatsApp;

// Fallback hardcodeado — se usa si Firestore tarda o falla
const _fallbackItems = [
  MenuItemModel(
    name: 'Torta Balcarce',
    subtitle: '',
    order: 1,
    prices: [MenuPriceItem(label: 'Grande (30cm)', price: '\$45.000')],
  ),
  MenuItemModel(
    name: 'Torta Chajá',
    subtitle: '',
    order: 2,
    prices: [MenuPriceItem(label: 'Grande (30cm)', price: '\$45.000')],
  ),
  MenuItemModel(
    name: 'Torta Toffi',
    subtitle: '',
    order: 3,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$45.000'),
      MenuPriceItem(label: 'Chica', price: '\$30.000'),
    ],
  ),
  MenuItemModel(
    name: 'Torta Frutal',
    subtitle: '',
    order: 4,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$45.000'),
      MenuPriceItem(label: 'Chica', price: '\$30.000'),
    ],
  ),
  MenuItemModel(
    name: 'Cheesecake Frutilla',
    subtitle: '',
    order: 5,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$45.000'),
      MenuPriceItem(label: 'Chica', price: '\$35.000'),
    ],
  ),
  MenuItemModel(
    name: 'Torta Brownie',
    subtitle: '',
    order: 6,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$35.000'),
      MenuPriceItem(label: 'Chica', price: '\$30.000'),
    ],
  ),
  MenuItemModel(
    name: 'Torta Ricota',
    subtitle: 'Sola o con ddl',
    order: 7,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$30.000'),
      MenuPriceItem(label: 'Chica', price: '\$25.000'),
    ],
  ),
  MenuItemModel(
    name: 'Lemon Pie',
    subtitle: '',
    order: 8,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$30.000'),
      MenuPriceItem(label: 'Chica', price: '\$25.000'),
    ],
  ),
  MenuItemModel(
    name: 'Torta Coco',
    subtitle: '',
    order: 9,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$25.000'),
      MenuPriceItem(label: 'Chica', price: '\$20.000'),
    ],
  ),
  MenuItemModel(
    name: 'Pastafrola',
    subtitle: 'Membrillo o batata',
    order: 10,
    prices: [
      MenuPriceItem(label: 'Grande', price: '\$20.000'),
      MenuPriceItem(label: 'Chica', price: '\$15.000'),
    ],
  ),
  MenuItemModel(
    name: 'Budín Carrot Cake',
    subtitle: 'Con frosting',
    order: 11,
    prices: [MenuPriceItem(label: '', price: '\$15.000')],
  ),
];

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  late final Future<List<MenuItemModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = MenuService.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.creamDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: FutureBuilder<List<MenuItemModel>>(
        future: _future,
        builder: (context, snap) {
          final items = (snap.hasData && snap.data!.isNotEmpty)
              ? snap.data!
              : _fallbackItems;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LO QUE PREPARO', style: AppTextStyles.label()),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.display(size: 40),
                  children: const [
                    TextSpan(text: 'El '),
                    TextSpan(
                      text: 'menú',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              isMobile ? _MenuList(items: items) : _MenuGrid(items: items),
              const SizedBox(height: 40),
              const _CtaBox(),
            ],
          );
        },
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  final List<MenuItemModel> items;
  const _MenuGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final half = (items.length / 2).ceil();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _MenuColumn(items: items.sublist(0, half))),
        const SizedBox(width: 40),
        Expanded(child: _MenuColumn(items: items.sublist(half))),
      ],
    );
  }
}

class _MenuList extends StatelessWidget {
  final List<MenuItemModel> items;
  const _MenuList({required this.items});

  @override
  Widget build(BuildContext context) => _MenuColumn(items: items);
}

class _MenuColumn extends StatelessWidget {
  final List<MenuItemModel> items;
  const _MenuColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(children: items.map((i) => _MenuRow(item: i)).toList());
  }
}

class _MenuRow extends StatelessWidget {
  final MenuItemModel item;
  const _MenuRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
                if (item.subtitle.isNotEmpty)
                  Text(
                    item.subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: AppColors.warmGray,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: item.prices.map((p) => _PriceRow(p: p)).toList(),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final MenuPriceItem p;
  const _PriceRow({required this.p});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (p.label.isNotEmpty)
          Text(
            '${p.label}  ',
            style: GoogleFonts.nunito(fontSize: 11, color: AppColors.warmGray),
          ),
        Text(
          p.price,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}

class _CtaBox extends StatelessWidget {
  const _CtaBox();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_CtaText(), const SizedBox(height: 16), _WaCtaBtn()],
            )
          : Row(
              children: [
                Expanded(child: _CtaText()),
                const SizedBox(width: 20),
                _WaCtaBtn(),
              ],
            ),
    );
  }
}

class _CtaText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Querés hacer un pedido?',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Escribinos por WhatsApp y te respondemos a la brevedad.',
          style: AppTextStyles.body(size: 13),
        ),
      ],
    );
  }
}

class _WaCtaBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: launchWhatsApp,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.waGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'Escribir',
          style: GoogleFonts.nunito(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
