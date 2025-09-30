from .views import RegisterOrLoginView, PostListCreateView
from django.contrib import admin
from django.urls import path, include # 'include' ko import karein

urlpatterns = [
    path('auth/sync/', RegisterOrLoginView.as_view(), name='auth_sync'),
    path('admin/', admin.site.urls),
    path('api/v1/', include('api.urls')),
    path('posts/', PostListCreateView.as_view(), name='post_list_create'),# Hamare API app ke URLs
]
