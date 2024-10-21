# Use Python 3.11-slim to avoid distutils issues
FROM python:3.11

# Set environment variables to prevent Python from buffering stdout/stderr and writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV CORS_ALLOWED_ORIGINS=0.0.0.0

ENV DB_NAME: "mydatabase"
ENV DB_USER: "myuser"
ENV DB_PASSWORD: "mypassword"
ENV DB_HOST: "db"
ENV DB_PORT: 5432
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

EXPOSE 8000

# Set default command to run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

