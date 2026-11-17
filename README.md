<div align="center">

# 🧮 বাংলা গ্লাস ক্যালকুলেটর (Bangla Glass Calculator)

**ক্লাসিক Citizen SDC-3822C লেআউট এবং আধুনিক Glassmorphism ডিজাইনে তৈরি একটি পূর্ণাঙ্গ বাংলা অ্যান্ড্রয়েড ক্যালকুলেটর অ্যাপ।**

![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Built With](https://img.shields.io/badge/Built%20With-Capacitor%20%7C%20HTML5%20%7C%20JS-0EA5E9?style=for-the-badge&logo=capacitor&logoColor=white)
![Language](https://img.shields.io/badge/Language-বাংলা%20(Bengali)-10B981?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-purple?style=for-the-badge)

<br>

[![Download APK](https://img.shields.io/badge/📥_Download_APK-Releases-success?style=for-the-badge&logo=github)](https://github.com/mamavhuk/Basic_Bangla_Calculator/releases)

</div>

---

## ✨ মূল বৈশিষ্ট্যসমূহ (Key Features)

* **🎨 প্রিমিয়াম গ্লাস UI (Glassmorphism):** চোখের আরামদায়ক ডার্ক-গ্রেডিয়েন্ট ব্যাকগ্রাউন্ডের ওপর স্বচ্ছ কাঁচের মতো বাটন ও ডিসপ্লে ডিজাইন।
* **⌨️ ক্লাসিক Citizen কিপ্যাড লেআউট:** জনপ্রিয় **Citizen SDC-3822C** ক্যালকুলেটরের হুবহু বাটন পজিশন (`CHECK`, `AUTO REPLAY`, `MU`, `MRC`, `M-`, `M+`, `CORRECT` এবং বড় `+` বাটন)[cite: 1]।
* **🇧🇩 বড় বাংলা সংখ্যা ও দেশীয় কমা ফরম্যাট:** ডিসপ্লে এবং ইতিহাসে স্পষ্ট বড় বাংলা অক্ষরে ফলাফল দেখা যায় এবং হাজার, লক্ষ ও কোটি অনুযায়ী স্বয়ংক্রিয়ভাবে কমা বসে (যেমন: **`১০,১০,০০,০০০`**)।
* **📜 অটো-সেভ হিসাবের ইতিহাস (Auto-Saved History):** অ্যাপ বন্ধ করে পুনরায় চালু করলেও আগের সব হিসাব সেভ থাকে। ইতিহাসের যেকোনো ফলাফলে ট্যাপ করলে সেটি সরাসরি ডিসপ্লেতে চলে আসে।
* **🔄 স্টেপ চেক ও অটো রিপ্লে:** ভুল হিসাব যাচাই করার জন্য প্রতিটি ধাপ আলাদাভাবে দেখা (`CHECK →`) এবং স্বয়ংক্রিয়ভাবে প্লে করার (`AUTO REPLAY`) সুবিধা।

---

## 📱 বাটন ও ফাংশন পরিচিতি

| বাটন | কাজ (Function) |
| :--- | :--- |
| **`AC`** | সব হিসাব এবং স্টেপ মুছে ডিসপ্লে রিসেট করে |
| **`CORRECT ⌫`** | ভুল করে টাইপ করা শেষ ডিজিটটি মুছে ফেলে |
| **`CHECK →`** | হিসাবের প্রতিটি ধাপ (Step) একে একে সামনে এগিয়ে যাচাই করে |
| **`AUTO REPLAY`** | পুরো হিসাবের ধাপগুলো স্বয়ংক্রিয়ভাবে স্ক্রিনে প্লে করে দেখায় |
| **`MU` (Mark-Up)** | ক্রয়মূল্য ও লাভের হার থেকে বিক্রয়মূল্য (Mark-up) নির্ণয় করে |
| **`M+` / `M-` / `MRC`** | মেমোরিতে সংখ্যা যোগ, বিয়োগ, রিকল (১ম চাপ) এবং ক্লিয়ার (২য় চাপ) করে |
| **`০০`** | দ্রুত ডাবল শূন্য টাইপ করার জন্য |

---

## 🚀 কীভাবে ব্যবহার ও বিল্ড করবেন?

### ১. সরাসরি ফোনে ইনস্টল করতে:
1. এই রিপোজিটরির **[Releases](https://github.com/mamavhuk/Basic_Bangla_Calculator/releases)** সেকশনে যান।
2. সর্বশেষ ভার্সনের **`Bangla-Calculator.apk`** ফাইলটি ডাউনলোড করুন।
3. আপনার অ্যান্ড্রয়েড ফোনে ফাইলটি ওপেন করে ইনস্টল করুন।

### ২. Codespaces থেকে নতুন করে APK বিল্ড করতে:
প্রজেক্টের কোডে কোনো পরিবর্তন আনার পর নতুন APK তৈরি করতে টার্মিনালে নিচের কমান্ডটি রান করুন:

```bash
chmod +x make_apk.sh && ./make_apk.sh
