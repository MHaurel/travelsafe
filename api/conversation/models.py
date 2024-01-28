from countries.models import Country
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Message(models.Model):
    # ! : a message cannot exceed 255 characters
    content = models.CharField(max_length=255)
    date = models.DateField(auto_now_add=True)
    # ! previous = models.ForeignKey(self, blank=True)

    country = models.ForeignKey(Country, on_delete=models.CASCADE)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f"{self.owner}: {self.content}"


class Emoji(models.Model):
    name = models.CharField(max_length=255)
    icon = models.CharField(max_length=255)

    def __str__(self) -> str:
        return self.name


class Reaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.ForeignKey(Message, on_delete=models.CASCADE)
    emoji = models.ForeignKey(Emoji, on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f"USER: {self.user} ON {self.message} WITH {self.emoji}"
