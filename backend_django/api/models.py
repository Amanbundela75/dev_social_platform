from django.db import models

class UserProfile(models.Model):
    # Hum Firebase ke UID ko primary key banayenge
    firebase_uid = models.CharField(max_length=128, unique=True, primary_key=True)
    email = models.EmailField(unique=True, max_length=255)

    # Yeh @username hoga, jaise Twitter/Reddit par hota hai
    username = models.CharField(max_length=100, unique=True)

    display_name = models.CharField(max_length=150, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    profile_picture_url = models.URLField(max_length=500, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.username
