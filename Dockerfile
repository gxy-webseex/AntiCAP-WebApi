FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app

# System libraries required by opencv-python (cv2) via ultralytics/AntiCAP.
# Without libgl1, the app crashes on startup with:
# ImportError: libGL.so.1: cannot open shared object file
RUN apt-get update && apt-get install -y --no-install-recommends libgl1 libglib2.0-0 libgomp1 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# main.py already binds 0.0.0.0 and reads the PORT environment variable
# provided by Hostless (defaults to 6688 locally).
CMD ["python", "main.py"]
