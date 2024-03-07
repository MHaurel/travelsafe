from django.urls import path
from . import views

urlpatterns = [
    path("criteria/<int:pk>", views.UpdateCriteriaView.as_view(),
         name="update-criteria")
]
