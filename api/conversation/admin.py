from django.contrib import admin

from conversation.models import Message, Reaction, Emoji

# Register your models here.
admin.site.register(Message)
admin.site.register(Reaction)
admin.site.register(Emoji)
