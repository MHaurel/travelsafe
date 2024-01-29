from django.db import models
from django.contrib.auth import get_user_model

from countries.models import Country

User = get_user_model()


class Subscription(models.Model):
    date_created = models.DateTimeField(auto_now_add=True)

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    country = models.ForeignKey(Country, on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f"[SUB] User: {self.user} for country: {self.country}"
