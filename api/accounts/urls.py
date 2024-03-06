from django.urls import path

from rest_framework.authtoken.views import obtain_auth_token

from accounts import views

from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    path("accounts/<int:pk>", views.UpdateDestroyUser.as_view(),
         name="user-update-destroy"),

    path("accounts", views.RetrieveUser.as_view(),
         name="user-retrieve"),

    path("accounts/create", views.CreateUser.as_view(), name="user-create"),
    path("accounts/criteria",
         views.AddCriteriaView.as_view(), name="add-criteria"),

    path("login", views.LoginView.as_view(), name='login'),
    path("logout", views.LogoutView.as_view(), name='logout'),


    path("auth-token", obtain_auth_token, name="obtain-token"),

    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
