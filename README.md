# 🚀 DevConnect (TBH- TO BE Honest)

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg) ![Platform](https://img.shields.io/badge/Platform-Flutter%20%7C%20Django-blue) ![Status](https://img.shields.io/badge/status-in%20development-orange)

India's own social media platform for app developers. A space to connect, share knowledge, and showcase projects. Inspired by Twitter and Reddit, built for the Indian developer community.



---

## ✨ Key Features

-   **👤 User Authentication:** Secure sign-up and login using Firebase Authentication (Email/Password, Google Sign-In).
-   **📝 Create & Share Posts:** Share your thoughts, code snippets, project updates, and questions with the community.
-   **🌐 Real-time Feed:** A dynamic home feed to discover what other developers are talking about.
-   **💬 Engage & Discuss:** Comment on posts, ask questions, and provide solutions.
-   **🔼 Upvote/Downvote System:** Promote valuable content and filter out noise, similar to Reddit.
-   **🧑‍💻 Developer Profiles:** Showcase your skills, projects, and social links on your personal profile.
-   **#️⃣ Channels/Topics:** Dedicated channels for specific topics like #Flutter, #Django, #UIUX, #DevOps etc.

---

## 🛠️ Tech Stack

This project is built using a modern and scalable tech stack:

| Component | Technology |
| :--- | :--- |
| **Frontend** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) |
| **Backend** | ![Django](https://img.shields.io/badge/Django-092E20?style=for-the-badge&logo=django&logoColor=white) |
| **Database** | ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white) |
| **Real-time & Auth** | ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black) |
| **Hosting** | ![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) (Optional) |

---

## 📂 Project Structure

The repository is structured as a monorepo with two main directories:

-   `frontend_flutter/`: Contains the complete Flutter mobile application.
-   `backend_django/`: Contains the Django REST Framework project for the backend API.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following tools installed on your system:
-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Python 3.8+](https://www.python.org/downloads/) & `pip`
-   [PostgreSQL](https://www.postgresql.org/download/)
-   [Git](https://git-scm.com/downloads/)

### Installation

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/](https://github.com/)[Your GitHub Username]/[Your Repo Name].git
    cd [Your Repo Name]
    ```

2.  **Setup Backend (Django):**
    ```sh
    # Navigate to the backend directory
    cd backend_django

    # Create and activate a virtual environment
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`

    # Install dependencies
    pip install -r requirements.txt

    # Setup your PostgreSQL database and add credentials in a .env file
    # (Create a .env file from .env.example)

    # Run database migrations
    python manage.py migrate

    # Start the development server
    python manage.py runserver
    ```
    The backend API will be running at `http://127.0.0.1:8000`.

3.  **Setup Frontend (Flutter):**
    ```sh
    # Navigate to the frontend directory
    cd ../frontend_flutter

    # Setup Firebase for your Flutter app
    # 1. Go to Firebase Console and create a new project.
    # 2. Register your Android/iOS app.
    # 3. Download `google-services.json` and place it in `android/app/`.

    # Get Flutter packages
    flutter pub get

    # Run the app
    flutter run
    ```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

---

## 📧 Contact

[Your Name] - [@YourTwitterHandle] - [youremail@example.com]

Project Link: [https://github.com/[Your GitHub Username]/[Your Repo Name]](https://github.com/[Your GitHub Username]/[Your Repo Name])
