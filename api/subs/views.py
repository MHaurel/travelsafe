from countries.models import Country
from subs.serializers import SubscriptionSerializer
from subs.models import Subscription
from rest_framework import generics, authentication, permissions, status, response
from django.shortcuts import get_object_or_404
from rest_framework_simplejwt.authentication import JWTAuthentication

from django.contrib.auth import get_user_model

from subs.permissions import IsOwner

User = get_user_model()


class CreateSubscription(generics.CreateAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def create(self, request, *args, **kwargs):
        serializer = SubscriptionSerializer(data=request.data)
        if serializer.is_valid():

            country_pk = self.kwargs.get('pk')
            country = get_object_or_404(Country, pk=country_pk)

            user = self.request.user

            serializer.save(user=user, country=country)

            return response.Response(serializer.data, status=status.HTTP_201_CREATED)
        return response.Response(serializer.errors, status=status)


class DeleteSubscription(generics.DestroyAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]


class ListSubscription(generics.ListAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [JWTAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Subscription.objects.filter(user=user)
