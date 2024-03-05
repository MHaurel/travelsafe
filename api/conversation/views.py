from rest_framework import generics, authentication, permissions, response, status, views
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404

from conversation.permissions import IsOwner

from conversation.models import Message, Reaction, Emoji
from conversation.serializers import MessageSerializer, ReactionSerializer, EmojiSerializer

from countries.models import Country

User = get_user_model()


class ListMessagesForCountry(generics.ListAPIView):
    serializer_class = MessageSerializer

    def get_queryset(self):
        country_pk = self.kwargs.get('pk')
        return Message.objects.filter(country=country_pk).order_by('-date')


class ListChildrenMessages(generics.ListAPIView):
    serializer_class = MessageSerializer

    def get_queryset(self):
        message_pk = self.kwargs.get('pk')
        return Message.objects.filter(parent=message_pk).order_by('date')


class MessageCreateAPIView(views.APIView):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, *args, **kwargs):
        serializer = MessageSerializer(data=request.data)
        if serializer.is_valid():

            user_id = request.data.get('user')
            country_id = request.data.get('country')
            parent_id = request.data.get('parent')

            # Use get_object_or_404 to raise a 404 error if the objects don't exist
            user = get_object_or_404(User, pk=user_id)
            country = get_object_or_404(Country, pk=country_id)
            parent = get_object_or_404(Message, pk=parent_id)

            # Pass user and country instances directly to save method
            serializer.save(user=user, country=country, parent=parent)

            # serializer.save()
            return response.Response(serializer.data, status=status.HTTP_201_CREATED)
        return response.Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class DeleteMessage(generics.DestroyAPIView):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]


class CreateReaction(generics.CreateAPIView):
    queryset = Reaction.objects.all()
    serializer_class = ReactionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def create(self, request, *args, **kwargs):
        message_pk = self.kwargs.get('pk')
        message = get_object_or_404(Message, pk=message_pk)

        user = self.request.user

        emoji_pk = self.request.data.get('emoji')
        emoji = get_object_or_404(Emoji, pk=emoji_pk)

        data = {
            'user': user.id,
            'message': message.pk,
            'emoji': emoji.pk
        }

        print(data)

        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)

        self.perform_create(serializer)

        return response.Response(serializer.data, status=status.HTTP_201_CREATED)


class DeleteReaction(generics.DestroyAPIView):
    queryset = Reaction.objects.all()
    serializer_class = ReactionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]


class ListReaction(generics.ListAPIView):
    serializer_class = ReactionSerializer

    def get_queryset(self):
        message_pk = self.kwargs.get('pk')
        return Reaction.objects.filter(message=message_pk)
