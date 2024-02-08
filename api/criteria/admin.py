from django.contrib import admin

# Register your models here.
from criteria.models import Criteria, TypeCriteria

admin.site.register(Criteria)
admin.site.register(TypeCriteria)
