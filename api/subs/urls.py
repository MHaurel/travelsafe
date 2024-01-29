from django.urls import path

from subs import views

urlpatterns = [
    path('subscription/create/<int:pk>',
         views.CreateSubscription.as_view(), name="create-subscription"),
    path('subscription/delete/<int:pk>',
         views.DeleteSubscription.as_view(), name="delete-subscription"),
    path('subscription/', views.ListSubscription.as_view(),
         name="get-subscriptions"),
]
