from rest_framework import serializers
from .models import UserProfile

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        # Sabhi fields ko include karein
        fields = ('firebase_uid', 'email', 'username', 'display_name', 'bio', 'profile_picture_url', 'created_at')
        read_only_fields = ('created_at',)
        # Firebase UID aur Email create karte time required honge
        extra_kwargs = {
            'firebase_uid': {'write_only': True, 'required': True},
            'email': {'required': True}
        }
