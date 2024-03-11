from django.urls import path

from conversation import views

urlpatterns = [
    path("messages/<int:pk>", views.ListMessagesForCountry.as_view(),
         name="list-messages-for-country"),
    path("messages/children/<int:pk>",
         views.ListChildrenMessages.as_view(), name="list-children-messages"),
    path("messages/delete/<int:pk>",
         views.DeleteMessage.as_view(), name="delete-message"),
    path("reaction/create/<int:pk>",
         views.CreateReaction.as_view(), name="create-reaction"),
    path("reaction/delete/<int:pk>",
         views.DeleteReaction.as_view(), name="delete-reaction"),
    path("messages/reaction/<int:pk>",
         views.ListReaction.as_view(), name="list-reaction"),
    path('messages/create/', views.MessageCreateAPIView.as_view(),
         name='message-create'),
]
