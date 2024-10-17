FROM python:3.11

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt /app/

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


# Copy the Django project files
COPY . .

# Expose the port that the Django app will run on
EXPOSE 8000

# Set the entrypoint to run Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]