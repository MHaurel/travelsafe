from rest_framework import generics, response

from criteria.models import Criteria
from criteria.serializers import CriteriaSerializer


class UpdateCriteriaView(generics.UpdateAPIView):
    queryset = Criteria.objects.all()
    serializer_class = CriteriaSerializer

    # TODO: auth, perms
