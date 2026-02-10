# Notes Keeper – Flutter & Supabase

A secure Notes Keeper mobile application built with **Flutter** and **Supabase**.  
The app allows users to create, update, and manage personal notes with strong backend security using **Row Level Security (RLS) and **real-time synchronization**.

---

# Features

- User authentication with Supabase Auth
- Secure CRUD operations using Row Level Security (RLS)
- Real-time updates for notes
- Clean and simple Flutter UI
- PostgreSQL database powered by Supabase

---

# Security

This project follows best backend security practices:

- Each note is linked to its owner using `user_id`
- Users can only read, insert, and update their own notes
- Row Level Security (RLS) is enforced at the database level
- Realtime updates respect all RLS policies

---

# Tech Stack

- **Flutter** – Frontend
- **Supabase** – Backend & Authentication
- **PostgreSQL** – Database
- **Supabase Realtime** – Live data sync

---

# Project Setup

### 1. Clone the repository
```bash
git clone https://github.com/your-username/notes-keeper-flutter-supabase.git
cd notes-keeper-flutter-supabase
