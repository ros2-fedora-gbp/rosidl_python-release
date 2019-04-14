@# Included from rosidl_generator_py/resource/_idl_pkg_typesupport_entry_point.c.em
@
@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    message=action.goal, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    message=action.result, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    message=action.feedback, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
TEMPLATE(
    '_srv_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    service=action.send_goal_service, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
TEMPLATE(
    '_srv_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    service=action.get_result_service, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
TEMPLATE(
    '_msg_pkg_typesupport_entry_point.c.em',
    package_name=package_name, idl_type=action.structure_type,
    message=action.feedback_message, typesupport_impl=typesupport_impl,
    include_directives=include_directives,
    register_functions=register_functions)
}@

@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
type_name = convert_camel_case_to_lower_case_underscore(action.structure_type.name)
function_name = 'type_support'
}@

@{
register_function = '_register_action_type__' + '__'.join(action.structure_type.namespaces[1:] + [type_name])
register_functions.append(register_function)
}@
int8_t
@(register_function)(PyObject * pymodule)
{
  int8_t err;
  PyObject * pyobject_@(function_name) = NULL;
  pyobject_@(function_name) = PyCapsule_New(
    (void *)ROSIDL_TYPESUPPORT_INTERFACE__ACTION_SYMBOL_NAME(rosidl_typesupport_c, @(', '.join(action.structure_type.namespaces + [action.structure_type.name])))(),
    NULL, NULL);
  if (!pyobject_@(function_name)) {
    // previously added objects will be removed when the module is destroyed
    return -1;
  }
  err = PyModule_AddObject(
    pymodule,
    "@(function_name)_action__@('__'.join(action.structure_type.namespaces[1:] + [type_name]))",
    pyobject_@(function_name));
  if (err) {
    // the created capsule needs to be decremented
    Py_XDECREF(pyobject_@(function_name));
    // previously added objects will be removed when the module is destroyed
    return err;
  }
  return 0;
}
