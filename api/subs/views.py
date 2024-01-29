from countries.models import Country
from subs.serializers import SubscriptionSerializer
from subs.models import Subscription
from rest_framework import generics

from django.contrib.auth import get_user_model

User = get_user_model()


class CreateSubscription(generics.CreateAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    # permission_classes = []
    # authentication_classes = []

    def perform_create(self, serializer):
        user_pk = self.request.data.get('user')
        country_pk = self.kwargs.get('pk')

        user = User.objects.get(pk=user_pk)
        country = Country.objects.get(pk=country_pk)

        serializer.save(user=user, country=country)


class DeleteSubscription(generics.DestroyAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    # permission_classes = []
    # authentication_classes = []


class ListSubscription(generics.ListAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    # permission_classes = []
    # authentication_classes = []

    # def get_queryset(self):
    # FIXME: get the user from the request once the authentication has been realized
    # user = User.objects.get(pk=self.request.data.get('user'))
    # return Subscription.objects.filter(user=user)
    # return super().get_queryset(self)
