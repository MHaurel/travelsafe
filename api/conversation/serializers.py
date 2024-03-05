from accounts.serializers import UserSerializer
from countries.serializers import CountrySerializer
from rest_framework import serializers

from conversation.models import Message, Emoji, Reaction

from countries.models import Country
from django.contrib.auth import get_user_model

User = get_user_model()


class MessageSerializer(serializers.ModelSerializer):
    # country = serializers.PrimaryKeyRelatedField(read_only=True)
    # user = serializers.PrimaryKeyRelatedField(read_only=True)
    country = CountrySerializer(read_only=True)
    user = UserSerializer(read_only=True)

    class Meta:
        model = Message
        fields = ['id', 'content', 'date', 'country', 'user', 'parent']
        depth = 3

    def create(self, validated_data):
        return Message.objects.create(**validated_data)


class EmojiSerializer(serializers.ModelSerializer):
    class Meta:
        model = Emoji
        fields = "__all__"
        # depth = 1


class ReactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reaction
        fields = "__all__"
        depth = 1
