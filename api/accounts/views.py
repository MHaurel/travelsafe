from accounts.serializers import UserSerializer
from rest_framework import generics, status, response, authentication, permissions
from rest_framework.authtoken.models import Token

from accounts.permissions import IsOwner

from django.contrib.auth import get_user_model, login, logout, authenticate

# User = get_user_model()
from .models import CustomUser


class RetrieveUpdateDestroyUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    lookup_field = 'pk'  # Specify the lookup field

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]


class CreateUser(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def perform_create(self, serializer):
        user = CustomUser.objects.create_user(
            email=serializer.validated_data['email'],
            password=serializer.validated_data['password']
        )
        Token.objects.create(user=user)


class LoginView(generics.CreateAPIView):
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        email = request.data.get("email")
        password = request.data.get("password")
        user = CustomUser.objects.filter(email=email).first()

        if user and user.check_password(password):
            token, _ = Token.objects.get_or_create(user=user)
            return response.Response({'token': token.key})

        print("password: " + user.password)
        print(user.check_password(password))
        return response.Response({'error': 'Invalid credentials'}, status=400)


class LogoutView(generics.GenericAPIView):
    # authentication_classes = (authentication.TokenAuthentication,)

    def post(self, request, *args, **kwargs):
        logout(request)
        return response.Response({'detail': 'Successfully logged out.'})
