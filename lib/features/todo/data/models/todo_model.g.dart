// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return TodoModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: _$enumDecodeNullable(_$TodoCategoryEnumMap, json['category']),
    type: _$enumDecodeNullable(_$TodoListTypeEnumMap, json['type']),
    priority: _$enumDecodeNullable(_$TodoPriorityEnumMap, json['priority']),
    isComplete: json['isComplete'] as bool,
    created: json['created'] as String,
  );
}

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$TodoCategoryEnumMap[instance.category],
      'type': _$TodoListTypeEnumMap[instance.type],
      'priority': _$TodoPriorityEnumMap[instance.priority],
      'isComplete': instance.isComplete,
      'created': instance.created,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TodoCategoryEnumMap = {
  TodoCategory.none: 'none',
  TodoCategory.business: 'business',
  TodoCategory.errands: 'errands',
  TodoCategory.home: 'home',
  TodoCategory.personal: 'personal',
  TodoCategory.work: 'work',
};

const _$TodoListTypeEnumMap = {
  TodoListType.all: 'all',
  TodoListType.todo: 'todo',
  TodoListType.inProgress: 'inProgress',
  TodoListType.completed: 'completed',
};

const _$TodoPriorityEnumMap = {
  TodoPriority.none: 'none',
  TodoPriority.low: 'low',
  TodoPriority.medium: 'medium',
  TodoPriority.high: 'high',
};
