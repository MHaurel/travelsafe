from django.urls import path

from rest_framework.authtoken.views import obtain_auth_token

from accounts import views

urlpatterns = [
    path("accounts/<int:pk>", views.RetrieveUpdateDestroyUser.as_view(),
         name="user-retrieve-update-destroy"),

    path("accounts", views.CreateUser.as_view(), name="user-create"),
    path("accounts/criteria",
         views.AddCriteriaView.as_view(), name="add-criteria"),

    path("login", views.LoginView.as_view(), name='login'),
    path("logout", views.LogoutView.as_view(), name='logout'),


    path("auth-token", obtain_auth_token, name="obtain-token")
]
