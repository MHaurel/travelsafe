from criteria.serializers import CriteriaSerializer
from accounts.serializers import UserSerializer
from rest_framework import generics, status, response, authentication, permissions
from rest_framework.authtoken.models import Token

from accounts.permissions import IsOwner

from django.contrib.auth import get_user_model, login, logout, authenticate

# User = get_user_model()
from .models import CustomUser


class UpdateDestroyUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]


class RetrieveUser(generics.RetrieveUpdateDestroyAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        if request.user:
            serializer = UserSerializer(request.user)
            return response.Response(serializer.data, status=status.HTTP_200_OK)

        return response.Response({'data': 'Could not retrieve the user'}, status=status.HTTP_404_NOT_FOUND)


class CreateUser(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def perform_create(self, serializer):
        print("create user")
        user = CustomUser.objects.create_user(
            email=serializer.validated_data['email'],
            password=serializer.validated_data['password']
        )
        Token.objects.create(user=user)


class LoginView(generics.CreateAPIView):
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        try:
            email = request.data.get("email")
            password = request.data.get("password")
            user = CustomUser.objects.filter(email=email).first()

            if user and user.check_password(password):
                token, _ = Token.objects.get_or_create(user=user)
                return response.Response({'token': token.key})

            print("password: " + user.password)
            print(user.check_password(password))

            return response.Response({'error': 'Invalid credentials'}, status=400)
        except:
            return response.Response({'error': 'Invalid credentials'}, status=400)


class LogoutView(generics.GenericAPIView):
    # authentication_classes = (authentication.TokenAuthentication,)

    def post(self, request, *args, **kwargs):
        logout(request)
        return response.Response({'detail': 'Successfully logged out.'})


class AddCriteriaView(generics.CreateAPIView):
    serializer_class = CriteriaSerializer

    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsOwner]

    def post(self, request, *args, **kwargs):
        # create the criteria
        print(request.data)

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        new_criteria = serializer.save()

        # assign the criteria to the user
        if request.data.get("name") == "Sécurité du pays":
            request.user.criteria_security = new_criteria
        elif request.data.get("name") == "Respect du droit des femmes et des enfants":
            request.user.criteria_women_children = new_criteria
        elif request.data.get("name") == "Risques sanitaires du pays":
            request.user.criteria_sanitary = new_criteria
        elif request.data.get("name") == "Climat sociopolitique du pays":
            request.user.criteria_sociopolitical = new_criteria
        elif request.data.get("name") == "Conséquences liées au changement climatique dans le pays visité":
            request.user.criteria_climate = new_criteria
        elif request.data.get("name") == "Us et coutumes du pays":
            request.user.criteria_customs = new_criteria
        elif request.data.get("name") == "Respect des droits LGBTQ+":
            request.user.criteria_lgbt = new_criteria
        elif request.data.get("name") == "Allergies alimentaires dans le pays":
            request.user.criteria_allergy = new_criteria
        else:
            print("Not existing")

        try:
            request.user.save()
            return response.Response({}, status=status.HTTP_201_CREATED)
        except:
            print("Error")
            return response.Response({}, status=status.HTTP_400_BAD_REQUEST)
