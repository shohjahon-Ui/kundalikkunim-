# Kundalik ni internetga chiqarish (PythonAnywhere, bepul)

Vercel Django + SQLite uchun mos emas (u doimiy fayl/baza saqlay olmaydi). PythonAnywhere esa aynan Django uchun.

1. https://www.pythonanywhere.com da bepul ("Beginner") hisob oching. Saytingiz manzili: `USERNAME.pythonanywhere.com`
2. **Files** bo'limiga `kundalik.zip` ni yuklang. **Consoles > Bash** oching:
   ```
   unzip kundalik.zip
   cd kundalik          # ichida manage.py turgan papka
   mkvirtualenv kundalik --python=python3.12
   pip install -r requirements.txt
   python manage.py migrate
   python manage.py collectstatic --noinput
   ```
3. **Web > Add a new web app > Manual configuration > Python 3.12**
   - Source code va Working directory: `/home/USERNAME/kundalik` (manage.py turgan papka)
   - Virtualenv: `/home/USERNAME/.virtualenvs/kundalik`
4. **WSGI configuration file** ichidagi hamma narsani o'chirib, shuni yozing (USERNAME ni almashtiring):
   ```python
   import os, sys
   path = '/home/USERNAME/kundalik'
   if path not in sys.path:
       sys.path.insert(0, path)
   os.environ['DJANGO_SETTINGS_MODULE'] = 'kundalik.settings'
   os.environ['DEBUG'] = '0'
   os.environ['SECRET_KEY'] = 'bu-yerga-uzun-tasodifiy-matn-yozing'
   os.environ['ALLOWED_HOSTS'] = 'USERNAME.pythonanywhere.com'
   os.environ['CSRF_TRUSTED_ORIGINS'] = 'https://USERNAME.pythonanywhere.com'
   os.environ['GOOGLE_CLIENT_ID'] = 'sizning-client-id.apps.googleusercontent.com'
   # Email orqali ro'yxatdan o'tish uchun (Gmail "App password" kerak):
   # os.environ['EMAIL_HOST_USER'] = 'sizning@gmail.com'
   # os.environ['EMAIL_HOST_PASSWORD'] = '16-xonali-app-parol'
   from django.core.wsgi import get_wsgi_application
   application = get_wsgi_application()
   ```
5. **Web > Static files** ga qo'shing:
   - `/static/`  ->  `/home/USERNAME/kundalik/staticfiles`
   - `/media/`   ->  `/home/USERNAME/kundalik/media`
6. Google Cloud Console > Credentials > sizning OAuth client > **Authorized JavaScript origins** ga `https://USERNAME.pythonanywhere.com` ni qo'shing.
7. **Web** sahifasida yashil **Reload** tugmasini bosing. Saytingiz tayyor.

Eslatma: Gmail SMTP yo'q bo'lsa, email bilan ro'yxatdan o'tishda tasdiqlash xati yuborilmaydi. Bunda faqat "Google bilan kirish" ishlaydi.
