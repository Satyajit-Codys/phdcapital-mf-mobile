import 'package:flutter/material.dart';
import '../core/constants/app_borders.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class AppSearchableDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;
  final bool enabled;

  const AppSearchableDropdown({
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
      canRequestFocus: false,
      skipTraversal: true,
      child: SizedBox(
        height: 56,
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
                height: 1,
              ),
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            child: hasValue
                ? Text(
                    labelBuilder(value as T),
                    style: AppTextStyles.inputText.copyWith(height: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true, // ✅ prevents going under status bar
      backgroundColor: AppColors.white100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, scrollController) {
            return _SearchableList<T>(
              values: values,
              labelBuilder: labelBuilder,
              selectedValue: value,
              onChanged: (item) {
                Navigator.pop(context);
                onChanged(item);
              },
              scrollController: scrollController, // pass this
            );
          },
        );
      },
    );
  }
}

class _SearchableList<T> extends StatefulWidget {
  final List<T> values;
  final String Function(T) labelBuilder;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final ScrollController scrollController; // ✅ added

  const _SearchableList({
    required this.values,
    required this.labelBuilder,
    required this.selectedValue,
    required this.onChanged,
    required this.scrollController,
  });

  @override
  State<_SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<_SearchableList<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredValues = [];

  @override
  void initState() {
    super.initState();
    _filteredValues = widget.values;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredValues = widget.values;
      } else {
        _filteredValues = widget.values
            .where(
              (item) => widget.labelBuilder(item).toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),

          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: false, // ✅ IMPORTANT
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: AppTextStyles.inputText.copyWith(
                  color: AppColors.grey400,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.grey400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.grey300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary500),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // List
          Expanded(
            child: _filteredValues.isEmpty
                ? Center(
                    child: Text(
                      "No results found",
                      style: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  )
                : ListView.separated(
                    controller: widget.scrollController, // ✅ important
                    itemCount: _filteredValues.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final item = _filteredValues[index];
                      final isSelected = item == widget.selectedValue;

                      return ListTile(
                        onTap: () => widget.onChanged(item),
                        title: Text(
                          widget.labelBuilder(item),
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
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
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
