from django.db import models

# Create your models here.
from risks.models import Risk, RiskLevel


class Country(models.Model):
    name = models.CharField(max_length=255)
    last_edition = models.DateTimeField(auto_now=True)

    # Ajouter un champ par section
    # Condition des femmes et des enfants
    risk_women_children = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_women_children", null=True)

    # Respect des droits LGBTQ+
    risk_lgbt = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_lgbt", null=True)

    # Les us et coutumes du pays visité
    risk_customs = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_customs", null=True)

    # Conséquences liées au changement climatique dans le pays visité
    risk_climate = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_climate", null=True)

    # Climat sociopolitique du pays visité
    risk_sociopolitical = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_sociopolitical", null=True)

    # Risques sanitaires dans le pays visité (Médical)
    risk_sanitary = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_sanitary", null=True)

    # Sécurité du pays visité
    risk_security = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_security", null=True)

    # Nourriture
    risk_food = models.ForeignKey(
        Risk, on_delete=models.CASCADE, related_name="country_risk_food", null=True)

    def __str__(self) -> str:
        return self.name
