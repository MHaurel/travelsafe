from django.urls import path

from countries import views

urlpatterns = [
    path("countries/", views.CountriesList.as_view(), name="countries-list"),
    path("country/<int:pk>/", views.CountryRetrieve.as_view(),
         name="country-retrieve")
]
