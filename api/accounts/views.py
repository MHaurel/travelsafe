from accounts.serializers import UserSerializer
from rest_framework import generics, status, response
from rest_framework.authtoken.models import Token

from django.contrib.auth import get_user_model, login, logout

User = get_user_model()


class RetrieveUpdateDestroyUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    lookup_field = 'pk'  # Specify the lookup field

    # permission_classes = []
    # authentication_classes = []


class CreateUser(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class LoginView(generics.CreateAPIView):
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        login(request, user)
        token, _ = Token.objects.get_or_create(user=user)
        return response.Response({'token': token.key})


class LogoutView(generics.GenericAPIView):
    # authentication_classes = (authentication.TokenAuthentication,)

    def post(self, request, *args, **kwargs):
        logout(request)
        return response.Response({'detail': 'Successfully logged out.'})
