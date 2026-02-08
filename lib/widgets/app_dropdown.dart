import 'package:flutter/material.dart';
import '../core/constants/app_borders.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class AppDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.hint,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
    this.value,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;

    return Focus(
      canRequestFocus: false, // 🚨 KEY LINE
      skipTraversal: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: enabled ? () => _openSheet(context) : null,
        child: InputDecorator(
          isEmpty: !hasValue,
          decoration: InputDecoration(
            border: AppBorders.normal,
            enabledBorder: AppBorders.normal,
            focusedBorder: AppBorders.selected,
            hintText: hint,
            hintStyle: AppTextStyles.inputText.copyWith(
              color: AppColors.grey400,
            ),
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
          ),
          child: hasValue
              ? Text(labelBuilder(value as T), style: AppTextStyles.inputText)
              : null,
        ),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: values.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, index) {
              final item = values[index];
              final isSelected = item == value;

              return ListTile(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  onChanged(item);
                },
                title: Text(
                  labelBuilder(item),
                  style: AppTextStyles.body3SemiBold.copyWith(
                    color: isSelected
                        ? AppColors.primary500
                        : AppColors.black100,
                  ),
                ),
                trailing: _radio(isSelected),
              );
            },
          ),
        );
      },
    );
  }

  Widget _radio(bool selected) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary500 : AppColors.grey300,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary500,
                ),
              ),
            )
          : null,
    );
  }
}
