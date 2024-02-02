from countries.models import Country
from subs.serializers import SubscriptionSerializer
from subs.models import Subscription
from rest_framework import generics, authentication, permissions, status, response
from django.shortcuts import get_object_or_404

from django.contrib.auth import get_user_model

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
    permission_classes = [permissions.IsAuthenticated]


class ListSubscription(generics.ListAPIView):
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    # def get_queryset(self):
    # FIXME: get the user from the request once the authentication has been realized
    # user = User.objects.get(pk=self.request.data.get('user'))
    # return Subscription.objects.filter(user=user)
    # return super().get_queryset(self)
