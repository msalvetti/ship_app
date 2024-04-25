import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/show_alert_dialog.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app_entity.dart';

class CreateOrEditAppScreen extends ConsumerStatefulWidget {
  const CreateOrEditAppScreen({super.key, this.app});
  final AppEntity? app;

  @override
  ConsumerState<CreateOrEditAppScreen> createState() =>
      _CreateOrEditAppScreenState();
}

class _CreateOrEditAppScreenState extends ConsumerState<CreateOrEditAppScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  void initState() {
    super.initState();
    if (widget.app != null) {
      _name = widget.app?.name ?? '';
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final db = ref.read(appDatabaseProvider);
        final existingApp = widget.app;
        if (existingApp != null) {
          await db.editAppName(projectId: existingApp.id, newName: _name);
        } else {
          await db.createNewApp(name: _name);
        }
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        // TODO: Improve error handling
        showAlertDialog(
          context: context,
          title: 'Error Saving Data',
          content: e.toString(),
          defaultActionText: 'OK',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app == null ? 'New App' : 'Edit App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'App name'),
                    keyboardAppearance: Theme.of(context).brightness,
                    initialValue: _name,
                    validator: (value) => (value ?? '').isNotEmpty
                        ? null
                        : 'Name can\'t be empty',
                    onSaved: (value) => _name = value ?? '',
                  ),
                  gapH16,
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
