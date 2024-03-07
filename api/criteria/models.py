from django.db import models


class TypeCriteria(models.Model):
    name = models.CharField(max_length=128)

    def __str__(self) -> str:
        return self.name


class Criteria(models.Model):
    name = models.CharField(max_length=128)
    grade = models.IntegerField()
    types = models.ManyToManyField(
        TypeCriteria, blank=True, related_name="criteria_types")

    def __str__(self) -> str:
        return f"{self.name}: {self.grade}"
