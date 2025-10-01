from rest_framework import serializers
from .models import UserProfile, Post

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

# Naya Post serializer add karein
class PostSerializer(serializers.ModelSerializer):
    # Hum author ka username bhi saath mein bhejna chahte hain, sirf ID nahi
    author_username = serializers.ReadOnlyField(source='author.username')

    # Author ki ID post create karte time Flutter app se aayegi
    author = serializers.PrimaryKeyRelatedField(
        queryset=UserProfile.objects.all(),
        write_only=True,
        source='author' # Explicitly define the source
    )

    class Meta:
        model = Post
        fields = ['id', 'author', 'author_username', 'content', 'created_at']
        read_only_fields = ['author_username', 'created_at']
