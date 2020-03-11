from rest_framework import serializers
from apps.config.models import JobConfig
class JobConfigSerializer(serializers.ModelSerializer):
    """Class for Job Service Config Serializer."""
    class Meta:
        """Nested Meta Class."""
        model = JobConfig
        fields = '__all__'