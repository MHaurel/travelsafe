from rest_framework import serializers

from risks.models import Risk, RiskLevel


class RiskLevelSerializer(serializers.ModelSerializer):
    class Meta:
        model = RiskLevel
        fields = "__all__"


class RiskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Risk
        fields = "__all__"
