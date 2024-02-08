from django.contrib import admin

from risks.models import Risk, RiskLevel

admin.site.register(Risk)
admin.site.register(RiskLevel)
