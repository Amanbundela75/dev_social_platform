from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from .models import UserProfile, Post
from .serializers import UserProfileSerializer, PostSerializer
from .permissions import IsAuthenticatedOrReadOnly

class RegisterOrLoginView(APIView):
    """
    Ek API View jo Firebase se login/register hone ke baad
    user ko Django DB mein sync karta hai.
    """
    def post(self, request, format=None):
        firebase_uid = request.data.get('firebase_uid')
        email = request.data.get('email')

        if not firebase_uid or not email:
            return Response({'error': 'Firebase UID and Email are required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Check karein ki user pehle se DB mein hai ya nahi
            user = UserProfile.objects.get(firebase_uid=firebase_uid)
            serializer = UserProfileSerializer(user)
            # User pehle se hai, toh bas uski details bhej do (Login)
            return Response(serializer.data, status=status.HTTP_200_OK)

        except UserProfile.DoesNotExist:
            # User nahi hai, naya create karo (Register)

            # Ek basic unique username generate kar rahe hain.
            # User isko baad mein change kar payega.
            username = email.split('@')[0].replace('.', '_') + '_' + firebase_uid[:5]

            data = {
                'firebase_uid': firebase_uid,
                'email': email,
                'username': request.data.get('username', username),
                'display_name': request.data.get('display_name', email.split('@')[0]),
                'profile_picture_url': request.data.get('profile_picture_url', '')
            }

            serializer = UserProfileSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)

            # Agar username already exists (bohot rare case), toh error handle karein
            if 'username' in serializer.errors:
                data['username'] = email.split('@')[0] + '_' + firebase_uid[:8] # Thoda alag username
                serializer = UserProfileSerializer(data=data)
                if serializer.is_valid():
                    serializer.save()
                    return Response(serializer.data, status=status.HTTP_201_CREATED)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
# Naya Post view add karein
class PostListCreateView(generics.ListCreateAPIView):
    """
    View to list all posts or create a new one.
    GET: Returns a list of all posts.
    POST: Creates a new post.
    """
    queryset = Post.objects.all()
    serializer_class = PostSerializer

    # Is function ko override karke hum author ko set karenge
    def perform_create(self, serializer):
        # Flutter se hum 'author' field mein firebase_uid bhejenge
        author_uid = self.request.data.get('author')
        author_profile = UserProfile.objects.get(firebase_uid=author_uid)
        serializer.save(author=author_profile)
