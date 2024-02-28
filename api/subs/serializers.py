from rest_framework import serializers

from subs.models import Subscription


class SubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscription
        fields = "__all__"
        # depth = 1

        def create(self, validated_data):
            print(validated_data)
            return super().create(validated_data)
