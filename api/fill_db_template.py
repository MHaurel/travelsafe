# Through the django shell, fill the db

from countries.models import Country
from risks.models import Risk, RiskLevel
import json
import os

customs_json_path = os.path.join("..", "scraping", "countries_data.json")
with open(customs_json_path, 'r') as f:
    customs = json.load(f)

table = {country_name: real_country_name for country_name, real_country_name in zip(
    [c for c in customs], [c.name for c in Country.objects.all()])}

for cn, rcn in table.items():
    print("[Affecting...] " + rcn)
    # get the country
    country = Country.objects.get(name=rcn)
    # create a new risk
    rl = RiskLevel.objects.get(pk=4)
    new_risk = Risk.objects.create(
        name="Us et coutumes", description=customs[cn], risk_level=rl)
    # new_risk.save()
    # affect the new risk to the country
    country.risk_customs = new_risk
    country.save()

# Conséquences liées au changement climatique dans le pays visité
