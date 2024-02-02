from countries.models import Country
from subs.serializers import SubscriptionSerializer
from subs.models import Subscription
from rest_framework import generics, authentication, permissions, status, response
from django.shortcuts import get_object_or_404

from django.contrib.auth import get_user_model

from subs.permissions import IsOwner

User = get_user_model()


class CreateSubscription(generics.CreateAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def create(self, request, *args, **kwargs):
        country_pk = self.kwargs.get('pk')
        country = get_object_or_404(Country, pk=country_pk)

        user = self.request.user

        data = {
            "user": user.id, 'country': country.pk
        }

        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)

        self.perform_create(serializer)

        return response.Response(serializer.data, status=status.HTTP_201_CREATED)


class DeleteSubscription(generics.DestroyAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]


class ListSubscription(generics.ListAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Subscription.objects.filter(user=user)
