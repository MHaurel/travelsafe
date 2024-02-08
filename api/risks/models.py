from django.db import models


class RiskLevel(models.Model):
    level = models.IntegerField()
    label = models.TextField()

    def __str__(self) -> str:
        return f'{self.level}: {self.label}'


class Risk(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()

    risk_level = models.ForeignKey(RiskLevel, on_delete=models.CASCADE)

    # country = models.ForeignKey(Country, on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f"[{self.name}] - Niveau: {self.risk_level.level}"
