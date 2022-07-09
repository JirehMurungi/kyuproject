// this drop down will have the contents of the dropdwon elements that will appear in the form.
import 'package:kyuproject/views/forms/data/form_textfield.dart';

class DropDownField extends FormTextField {

  // list of drop down item strings
  final List<String> dropDownItems;
// DropdownButtonFormField

  DropDownField({
    required this.dropDownItems,
    required super.label,
    required super.hint,
    required super.validator,
    required super.formValueProvider,
  });
}
