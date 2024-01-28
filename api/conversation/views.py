from rest_framework import generics
from django.contrib.auth import get_user_model

from conversation.models import Message, Reaction, Emoji
from conversation.serializers import MessageSerializer, ReactionSerializer, EmojiSerializer

from countries.models import Country

User = get_user_model()


class ListMessagesForCountry(generics.ListAPIView):
    serializer_class = MessageSerializer

    # permission_classes = []
    # authentication_classes = []

    def get_queryset(self):
        country_pk = self.kwargs.get('pk')
        return Message.objects.filter(country=country_pk).order_by('-date')


class CreateMessageForCountry(generics.CreateAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

    # permission_classes = []
    # authentication_classes = []

    def perform_create(self, serializer):
        # print(self.request.data)
        content = self.request.data.get('content')
        country = Country.objects.get(pk=self.request.data.get('country'))

        # FIXME: use the self.request.user to get the user and not "user_id" in JSON body
        owner = User.objects.get(pk=self.request.data.get('owner'))
        serializer.save(content=content, country=country, owner=owner)


class DeleteMessage(generics.DestroyAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

    # permission_classes = []
    # authentication_classes = []


class CreateReaction(generics.CreateAPIView):
    queryset = Reaction.objects.all()
    serializer_class = ReactionSerializer

    # permission_classes = []
    # authentication_classes = []

    def perform_create(self, serializer):
        message_id = self.kwargs.get('pk')

        # FIXME: use the self.request.user to get the user and not "user_id" in JSON body
        user = User.objects.get(pk=self.request.data.get('owner'))
        message = Message.objects.get(pk=message_id)
        emoji = Emoji.objects.get(pk=self.request.data.get('emoji'))

        serializer.save(user=user, message=message, emoji=emoji)


class DeleteReaction(generics.DestroyAPIView):
    queryset = Reaction.objects.all()
    serializer_class = ReactionSerializer

    # permission_classes = []
    # authentication_classes = []
