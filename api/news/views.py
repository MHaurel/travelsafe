from rest_framework import generics

from news.models import News
from news.serializers import NewsSerializer


class NewsList(generics.ListAPIView):
    queryset = News.objects.order_by('-date')
    serializer_class = NewsSerializer

    # TODO: to define
    # authentication_classes = []
    # permission_classes = []


class NewsForCountry(generics.ListAPIView):
    # queryset = News.objects.all()
    serializer_class = NewsSerializer

    def get_queryset(self):
        country_pk = self.kwargs.get('pk')
        return News.objects.filter(country=country_pk).order_by("-date")

    # TODO: to define
    # authentication_classes = []
    # permission_classes = []
