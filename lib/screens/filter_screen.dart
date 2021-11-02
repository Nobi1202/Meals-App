import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilter;
  final Map<String, bool> currentFilter;

  const FilterScreen(this.currentFilter, {required this.saveFilter, Key? key})
      : super(key: key);

  static const routeName = '/filter';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;
  bool _vegan = false;

  @override
  initState() {
    if (widget.currentFilter['gluten'] != null) {
      _glutenFree = widget.currentFilter['gluten']!;
    }
    if (widget.currentFilter['vegetarian'] != null) {
      _vegetarian = widget.currentFilter['vegetarian']!;
    }
    if (widget.currentFilter['lactoseFree'] != null) {
      _lactoseFree = widget.currentFilter['lactoseFree']!;
    }
    if (widget.currentFilter['vegan'] != null) {
      _vegan = widget.currentFilter['vegan']!;
    }
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filter"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilter(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                    _glutenFree,
                    (newValue) => {
                          setState(
                            () {
                              _glutenFree = newValue;
                            },
                          )
                        }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _lactoseFree,
                    (newValue) => {
                          setState(
                            () {
                              _lactoseFree = newValue;
                            },
                          )
                        }),
                _buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _vegetarian,
                    (newValue) => {
                          setState(
                            () {
                              _vegetarian = newValue;
                            },
                          )
                        }),
                _buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals',
                    _vegan,
                    (newValue) => {
                          setState(
                            () {
                              _vegan = newValue;
                            },
                          )
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
