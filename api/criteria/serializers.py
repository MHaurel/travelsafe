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
