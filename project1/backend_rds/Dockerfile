# Use Python 3.11-slim to avoid distutils issues
FROM python:3.11

# Set environment variables to prevent Python from buffering stdout/stderr and writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container to /app
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt .

# Install setuptools (which replaces distutils)
# RUN pip install --upgrade pip setuptools

# Install the Python dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project code to the working directory
COPY . .

# Set environment variables for Django settings module
# ENV DJANGO_SETTINGS_MODULE=backend_rds.settings
# ENV CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:8080
# Expose port 8000 (for Django development server)
EXPOSE 8000

# Set default command to run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

