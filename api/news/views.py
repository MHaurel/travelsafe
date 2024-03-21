from rest_framework import generics

from news.models import News
from news.serializers import NewsSerializer


class NewsList(generics.ListAPIView):
    queryset = News.objects.order_by('-date')
    serializer_class = NewsSerializer


class NewsForCountry(generics.ListAPIView):
    serializer_class = NewsSerializer

    def get_queryset(self):
        country_pk = self.kwargs.get('pk')
        return News.objects.filter(country=country_pk).order_by("-date")


class LastNews(generics.ListAPIView):
    queryset = News.objects.all().order_by('-date')[:2]
    serializer_class = NewsSerializer


class LastNewsForCountry(generics.ListAPIView):
    serializer_class = NewsSerializer

    def get_queryset(self):
        country_pk = self.kwargs.get('pk')
        return News.objects.filter(country=country_pk).order_by('-date')[:2]
