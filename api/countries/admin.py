from django.contrib import admin

from countries.models import Country, Risk, RiskLevel
# Register your models here.
admin.site.register(Country)
admin.site.register(Risk)
admin.site.register(RiskLevel)