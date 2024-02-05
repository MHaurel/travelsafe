from django.urls import path

from news import views

urlpatterns = [
    path("news/", views.NewsList.as_view(), name="news-list"),
    path("news/<int:pk>", views.NewsForCountry().as_view(), name="news-for-country")
]