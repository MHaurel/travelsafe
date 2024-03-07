from rest_framework import generics

from countries.models import Country
from countries.serializers import CountrySerializer


class CountriesList(generics.ListAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer


class CountryRetrieve(generics.RetrieveAPIView):
    queryset = Country.objects.all()
    serializer_class = CountrySerializer
