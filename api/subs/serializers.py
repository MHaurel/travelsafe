from rest_framework import serializers

from subs.models import Subscription


class SubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscription
        fields = "__all__"
        depth = 4

        def create(self, validated_data):
            return super().create(validated_data)
