from countries.models import Country
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Message(models.Model):
    # ! : a message cannot exceed 255 characters
    content = models.TextField()
    date = models.DateTimeField(auto_now_add=True)
    parent = models.ForeignKey(
        'self', on_delete=models.CASCADE, null=True, blank=True, related_name="replies")

    country = models.ForeignKey(
        Country, on_delete=models.CASCADE, related_name="message_country")
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="message_user")

    def __str__(self) -> str:
        return f"[ID:{self.pk}] {self.user}: {self.content} - with parent: {self.parent}"


class Emoji(models.Model):
    name = models.CharField(max_length=255)
    icon = models.IntegerField()

    def __str__(self) -> str:
        return self.name


class Reaction(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="reaction_user")
    message = models.ForeignKey(
        Message, on_delete=models.CASCADE, related_name="reaction_message")
    emoji = models.ForeignKey(
        Emoji, on_delete=models.CASCADE, related_name="reaction_emoji")

    def __str__(self) -> str:
        return f"USER: {self.user} ON {self.message} WITH {self.emoji}"
