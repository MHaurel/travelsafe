from rest_framework import serializers

from django.contrib.auth import get_user_model

# User = get_user_model()
from .models import CustomUser


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=False)

    class Meta:
        model = CustomUser
        fields = ["id", "first_name", "last_name", "email", "password", "criteria_women_children", "criteria_security",
                  "criteria_sanitary", "criteria_sociopolitical", "criteria_climate", "criteria_customs", "criteria_lgbt", "criteria_allergy"]
        extra_kwargs = {'password': {'write_only': True}}
        depth = 2
