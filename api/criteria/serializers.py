from rest_framework import serializers

from criteria.models import Criteria, TypeCriteria


class TypeCriteriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = TypeCriteria
        fields = ['name']


class CriteriaSerializer(serializers.ModelSerializer):
    types = TypeCriteriaSerializer(many=True)

    class Meta:
        model = Criteria
        fields = ['name', 'grade', 'types']
        depth = 1

    def create(self, validated_data):
        types_data = validated_data.pop('types')
        criteria = Criteria.objects.create(**validated_data)
        for type_data in types_data:
            type_obj, _ = TypeCriteria.objects.get_or_create(**type_data)
            criteria.types.add(type_obj)
        return criteria

    def update(self, instance, validated_data):
        # Update the grade field if it's present in the validated data
        instance.grade = validated_data.get('grade', instance.grade)

        # Update the types field if it's present in the validated data
        types_data = validated_data.get('types')
        if types_data:
            for type_data in types_data:
                type_obj, _ = TypeCriteria.objects.get_or_create(**type_data)
                instance.types.add(type_obj)

        instance.save()
        return instance
