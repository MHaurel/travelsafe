from rest_framework import serializers

from django.contrib.auth import get_user_model

# User = get_user_model()
from .models import CustomUser
from criteria.serializers import CriteriaSerializer


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=False)
    # criteria_women_children = serializers.PrimaryKeyRelatedField(
    #     read_only=True)

    # criteria_women_children = CriteriaSerializer(read_only=True)

    # # Sécurité
    # criteria_security = CriteriaSerializer(read_only=True)

    # # Sanitaires
    # criteria_sanitary = CriteriaSerializer(read_only=True)

    # # Climat sociopolitique
    # criteria_sociopolitical = CriteriaSerializer(read_only=True)

    # # Conséquences liées au changement politique du pays
    # criteria_climate = CriteriaSerializer(read_only=True)

    # # Us et coutumes
    # criteria_customs = CriteriaSerializer(read_only=True)

    # # LGBTQ+
    # criteria_lgbt = CriteriaSerializer(read_only=True)

    # # Allergies alimentaires
    # criteria_allergy = CriteriaSerializer(read_only=True)

    class Meta:
        model = CustomUser
        fields = ["id", "first_name", "last_name", "email", "password", "criteria_women_children", "criteria_security",
                  "criteria_sanitary", "criteria_sociopolitical", "criteria_climate", "criteria_customs", "criteria_lgbt", "criteria_allergy"]
        extra_kwargs = {'password': {'write_only': True}}
        depth = 2

    def update(self, instance, validated_data):
        print(validated_data)
        return super().update(instance, validated_data)
