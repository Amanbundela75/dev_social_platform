from django.urls import path
from .views import RegisterOrLoginView
from django.contrib import admin
from django.urls import path, include # 'include' ko import karein

urlpatterns = [
    path('auth/sync/', RegisterOrLoginView.as_view(), name='auth_sync'),
    path('admin/', admin.site.urls),
    path('api/v1/', include('api.urls')), # Hamare API app ke URLs
]
