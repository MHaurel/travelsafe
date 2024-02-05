from django.urls import path

from conversation import views

urlpatterns = [
    path("messages/<int:pk>", views.ListMessagesForCountry.as_view(),
         name="list-messages-for-country"),
    path("messages/create/<int:pk>", views.CreateMessageForCountry.as_view(),
         name="create-messages-for-country"),
    path("messages/delete/<int:pk>",
         views.DeleteMessage.as_view(), name="delete-message"),
    path("reaction/create/<int:pk>",
         views.CreateReaction.as_view(), name="create-reaction"),
    path("reaction/delete/<int:pk>",
         views.DeleteReaction.as_view(), name="delete-reaction"),
]